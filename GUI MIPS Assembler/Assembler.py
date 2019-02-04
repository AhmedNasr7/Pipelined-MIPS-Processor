class Assembler():

    program = ""
    program_lines = ""
    opcodes = {
                "add": 32,
                "addi": 8,
                "sub": 34,
                "and": 36,
                "or": 37,
                "andi": 12,
                "ori":  13,
                "beq": 4,
                "bne": 5,
                "j": 2,
                "jal":3,
                "jr": 8,
                "lw": 35,
                "sw": 43,
                "sll":0,
                "slt": 42,
                "srl": 2,
                "nor": 39

    }

    command = ""
    binaries = []
    regs = []
    jump_addr = 0

    r_type = ['add', 'sub', 'and', 'or', 'jr', 'srl', 'sll', 'slt', 'nor']
    i_type_lw = ['lw', 'sw']
    i_type = ['beq', 'bne', 'addi', 'andi', 'ori']
    j_type = ['j']

    reg_file = {
                    "a0": 4,
                    "a1": 5,
                    "a2": 6,
                    "a3": 7,
                    "t0": 8,
                    "t1": 9,
                    "t2": 10,
                    "t3": 11,
                    "t4": 12,
                    "t5": 13,
                    "t6": 14,
                    "t7": 15,
                    "s0": 16,
                    "s1": 17,
                    "s2": 18,
                    "s3": 19,
                    "s4": 20,
                    "s5": 21,
                    "s6": 22,
                    "s7": 23,
                    "t8": 24,
                    "t9": 25,
                    "k0": 26,
                    "k1": 27

    }


    def __init__(self, program):
        self.program = program
        self.preprocess(self.program)
        self.assemble()



    def preprocess(self, program):
        self.program_lines = program.splitlines()
        #print(self.program_lines)


    
    def assemble(self):
        type = ""

        for line in self.program_lines:
            self.command = ""
            self.regs = []

            line = self.remove_spaces(line)
            s_index = line.find("$")
            if len(line):

                if s_index == -1:
                    if line[0] == 'j':
                        self.command = 'j'
                        self.jump_addr = int(line[1:len(line)])
                        type = "j"
                        #print(self.jump_addr)
                else:

                        self.command = line[0:s_index]
                        self.command = self.remove_spaces(self.command)
                        line_nocommand = line[s_index: len(line)]
                        # check if it lw or sw
                        br_index = line_nocommand.find("(")
                        #print(br_index)
                        if br_index != -1: #lw or sw

                            reg_1 = line_nocommand[1: 3]
                            reg_2 = line_nocommand[br_index+2: br_index+4]
                            self.regs.append(reg_1)
                            self.regs.append(reg_2)
                            c_index = line_nocommand.find(",")
                            val = line_nocommand[c_index+1: br_index]
                            val = int(val)
                            self.regs.append(val)
                            type = "lw"

                        else:
                            l = line_nocommand.split(',')
                            #print("l: ", l)
                            for e in l:
                                ind = e.find("$")
                                if ind != -1: # reg
                                    self.regs.append(e.replace("$", ""))
                                else:
                                    val = int(e)
                                    self.regs.append(val)
                #assemble line

                bin = ""
                opcode = self.opcodes[self.command]
                #print(opcode)
                #print(self.command)
                #print(self.regs)

                if (self.command in self.r_type):
                    funct = opcode
                    opcode = self.to_binary(0, 6)


                elif (self.command in self.i_type):
                    pass

                elif (self.command in self.i_type_lw):
                    pass

                elif (self.command in self.j_type):
                    pass



                if ((type == 'j')):

                    pass


            else:
                pass










    def load_to_file(self):
        pass


    def remove_spaces(self, text):
        s = text.strip()
        s = s.replace(" ", "")
        return s



    def to_binary(self, num, size):

        return bin(num)[2:].zfill(size)






"""
add $s1, $s2, $s3
lw $s1, 100 ($s2)
j 2500



"""


