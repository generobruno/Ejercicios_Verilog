""" MIPS Assembler


"""

import sys
import getopt

from utils.parser import InstructionParser

class Assembler(object):
    def __init__(self, infilenames, outfilename):
        self.infilenames = infilenames
        self.outfilename = outfilename
        
    def stripComments(self, line):
        if not line:
            return ''
        
        cleaned = line
        if line.find('#') != -1:
            cleaned = line[0:line.find('#')]
            
        return cleaned
    
    def buildLabelsMap(self, lines):
        labelsMap = {}
        
        for lineNo, line in enumerate(lines):
            split = line.split(':',1)
            if len(split) < 1:
                label = split[0]
                labelsMap[label] = lineNo
                
        return labelsMap
    
    def mergeInputFiles(self):
        outlines = []
        
        for filename in self.infilenames:
            with open(filename) as f:
                outlines += f.readlines()
                
            f.close()
            
        return outlines
    
    def AssemblyToHex(self):
        """ Given an ASCII assembly filee, read it in line by line and convert each one to machine code.
        Then save that to an outputfile
        """

        inlines = self.mergeInputFiles()
        outlines = []
        
        lines = map(lambda line: self.stripComments(line.rstrip()), inlines)
        lines = filter(lambda line: line, lines)
        
        labelsMap = self.buildLabelsMap(lines)
        parser = InstructionParser(labelsMap=labelsMap)
        
        outlines = map(lambda line: parser.convert(line, format='hex'), lines)
        
        with open(self.outfilename, 'w') as of:
            of.write('v2.0 raw\n')
            for outline in outlines:
                of.write(outline)
                of.write("\n")
                
        of.close()
        
if __name__ == "__main__":
    print(f'Number of args: {len(sys.argv)}')
    print(f'Arg List: {str(sys.argv)}')
    
    if (len(sys.argv) < 4) or ('-i' not in sys.argv) or ('-o' not in sys.argv):
        print('Usage: python assembler.py -i <input1.asm>[ <input2.asm> ...] -o <output.hex>')
        sys.exit(2)
        
    inputfiles = sys.argv[sys.argv.index('-i') + 1: sys.argv.index('-o')]
    outputfile = sys.argv[sys.argv.index('-o') + 1]
    
    assembler = Assembler(inputfiles, outputfile)
    assembler.AssemblyToHex()
