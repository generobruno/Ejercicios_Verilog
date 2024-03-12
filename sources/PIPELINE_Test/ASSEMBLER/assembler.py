import sys
import json

def assemble_instruction(instruction_name, instruction_args, instruction_format):
    binary_instruction = ""
    
    opcode = int(instruction_format[instruction_name][0], 16)
    if opcode == 0:
        # For SPECIAL opcode, the function code is used instead of opcode
        function_code = int(instruction_format[instruction_name][-1], 16)
        binary_instruction += f"{opcode:06b}"  # Opcode is 0 for SPECIAL
        binary_instruction += f"{int(instruction_args[1][1:].rstrip(',')):05b}"  # rs
        binary_instruction += f"{int(instruction_args[2][1:].rstrip(',')):05b}"  # rt
        binary_instruction += f"{int(instruction_args[0][1:].rstrip(',')):05b}"  # rd
        binary_instruction += "00000"  # shamt
        binary_instruction += f"{function_code:06b}"  # Function code
    else:
        binary_instruction += f"{opcode:06b}"  # Opcode
        
        # Fill in register fields
        for field in ["rs", "rt", "rd"]:
            if field in instruction_format[instruction_name]:
                register_arg = instruction_args.pop(0)
                if register_arg.endswith(","):
                    register_arg = register_arg[:-1]  # Remove trailing comma
                register = int(register_arg[1:])
                binary_instruction += f"{register:05b}"
            else:
                binary_instruction += "00000"

        # Fill in shamt field if present
        if "sa" in instruction_format[instruction_name]:
            shamt = int(instruction_args.pop(0)) if instruction_args else 0
            binary_instruction += f"{shamt:05b}"
        else:
            binary_instruction += "00000"

        # Fill in immediate field if present
        if "imm" in instruction_format[instruction_name]:
            immediate = int(instruction_args.pop(0)) if instruction_args else 0
            binary_instruction += f"{immediate & 0xFFFF:016b}"
        elif "addr" in instruction_format[instruction_name]:
            address = int(instruction_args.pop(0)) if instruction_args else 0
            binary_instruction += f"{address & 0x3FFFFFF:026b}"
        else:
            binary_instruction += "0000000000000000"

    return binary_instruction

def main():
    if len(sys.argv) != 2:
        print("Usage: python assembler.py <input.asm>")
        sys.exit(1)

    input_asm_file = sys.argv[1]
    output_obj_file = input_asm_file.replace(".asm", ".obj")

    # Load instruction format from JSON
    with open("InstructionsFormat.json") as json_file:
        instruction_format = json.load(json_file)

    # Read MIPS instructions from .asm file and generate .obj file
    with open(input_asm_file, 'r') as asm_file, open(output_obj_file, 'w') as obj_file:
        for line in asm_file:
            # Parse instruction from line
            instruction_parts = line.strip().split()
            instruction_name = instruction_parts[0]
            instruction_args = instruction_parts[1:]

            # Translate instruction to binary
            binary_instruction = assemble_instruction(instruction_name, instruction_args, instruction_format)

            # Write binary representation to .obj file
            obj_file.write(binary_instruction + '\n')

    print(f"Binary instructions saved to {output_obj_file}")

if __name__ == "__main__":
    main()
