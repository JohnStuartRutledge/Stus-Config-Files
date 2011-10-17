
import sys, os
import gzip
import bz2
import fnmatch

class fileScanner:
    '''
    A sweet file scanner that can locate text in files
    for example, to find all TODOs in all Python files
    residing within or as a subdirectory of Desktop:
    >>> scan = fileScanner.run('~/Desktop', '*.py', 'TODO')
    >>> print scan.next()
    
    TODO - combine the ability to search different types
           of files like in dirEntries above.
    '''
    def __init__(self):
        pass
    
    def pwd(self):
        return os.path.join(os.getcwd(), 'workzone')
    
    def run(self, topdir, file_pattern, line_pattern):
        files_found = self.find_file(topdir, file_pattern)
        file_opened = self.open_file(files_found)
        files_lines = self.cat(file_opened)
        match_lines = self.grep(line_pattern, files_lines)
        for line in match_lines:
            yield line
    
    def find_file(self, topdir, file_pattern):
        for path, dirname, filelist in os.walk(topdir):
            for name in filelist:
                if fnmatch.fnmatch(name, file_pattern):
                    yield os.path.join(path, name)
    
    def open_file(self, files_found):
        for name in files_found:
            if name.endswith(".gz"):    f = gzip.open(name)
            elif name.endswith(".bz2"): f = bz2.BZ2File(name)
            # elif pdf
            # elif CSV, TSV
            else: f = open(name)
            yield f
    
    def cat(self, file_opened):
        for f in file_opened:
            for line in f:
                yield line
    
    def grep(self, line_pattern, files_lines):
        for line in files_lines:
            if line_pattern in line:
                yield line

