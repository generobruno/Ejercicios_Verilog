import tkinter as tk
import customtkinter as ctk
from tkinter import filedialog, messagebox
import subprocess, os

current_file_path = ""

class IDE(ctk.CTk):
    def __init__(self):
        super().__init__()
        
        self.title("MIPSdb - Debugger")
        self.geometry("800x600")
        
        # File management
        self.files_frame = ctk.CTkFrame(self, height=5)
        self.files_frame.pack(side="top", fill="x", pady=2, padx=2)
        
        self.file_opt = ctk.CTkOptionMenu(self.files_frame,
                                          values=["Save", "Load"], 
                                          command=self.manage_file, 
                                          height=5,)
        self.file_opt.pack(side='left')
        
        self.filename_text = ctk.CTkTextbox(self.files_frame, height=1, wrap="none")
        self.filename_text.pack(side="left", fill="x", padx=5)

        # Text Editor
        self.text_editor = ctk.CTkTextbox(self)
        self.text_editor.pack(side="top", fill="both", expand=True, padx=3, pady=3)

        # Buttons
        self.buttons_frame = ctk.CTkFrame(self)
        self.buttons_frame.pack(side="top", fill="x", pady=2, padx=2)

        self.compile_button = ctk.CTkButton(self.buttons_frame, text="Compile", command=self.compile_file)
        self.compile_button.pack(side='left', pady=3, padx=1)

        self.write_button = ctk.CTkButton(self.buttons_frame, text="Write", command=self.write_code)
        self.write_button.pack(side='left', pady=3, padx=1)

        self.run_button = ctk.CTkButton(self.buttons_frame, text="Run", command=self.run_code)
        self.run_button.pack(side='left', pady=3, padx=1)
        
        self.file_ops = ctk.CTkOptionMenu(self, values=["open", "new"])

        # Mem-Reg-PC Frame
        self.bottom_frame = ctk.CTkFrame(self, height=80)
        self.bottom_frame.pack(side="bottom", fill="both", expand=True)

        # Registers Frame
        self.registers_frame = ctk.CTkFrame(self.bottom_frame)
        self.registers_frame.pack(side="left", fill="both", expand=True)

        self.registers_label = ctk.CTkLabel(self.registers_frame, text="Registers")
        self.registers_label.pack(side='top', pady=5)

        self.registers_text = ctk.CTkTextbox(self.registers_frame, height=3, width=30, wrap="none")
        self.registers_text.pack(side="left", fill="both", expand=True, pady=5)
        self.registers_text.configure(state=ctk.DISABLED)

        # Memory Frame
        self.memory_frame = ctk.CTkFrame(self.bottom_frame)
        self.memory_frame.pack(side="left", fill="both", expand=True)

        self.memory_label = ctk.CTkLabel(self.memory_frame, text="Memory")
        self.memory_label.pack(side='top', pady=5)

        self.memory_text = ctk.CTkTextbox(self.memory_frame, height=3, width=30, wrap="none")
        self.memory_text.pack(side="left", fill="both", expand=True, pady=5)
        self.memory_text.configure(state=ctk.DISABLED)

        # Program Counter Frame
        self.pc_frame = ctk.CTkFrame(self.bottom_frame)
        self.pc_frame.pack(side="left", fill="both", expand=True)

        self.pc_label = ctk.CTkLabel(self.pc_frame, text="Program Counter")
        self.pc_label.pack(side='top', pady=5)

        self.pc_value_label = ctk.CTkLabel(self.pc_frame, text="")
        self.pc_value_label.pack(side='top', pady=5)

        self.update_register_memory()

    """ manage_file
        Save or Load File depending on the option selected
    """
    def manage_file(self, option):
        global current_file_path  # Access the global variable
        if option == "Load":
            filename = filedialog.askopenfilename()
            if filename:
                current_file_path = filename
                name = os.path.basename(filename)  # Get only the filename
                self.filename_text.configure(state=tk.NORMAL)
                self.filename_text.delete(1.0, tk.END)
                self.filename_text.insert(tk.END, name)
                self.filename_text.configure(state=tk.DISABLED)
                with open(filename, 'r') as file:
                    self.text_editor.delete('1.0', tk.END)
                    self.text_editor.insert(tk.END, file.read())
        elif option == "Save":
            filename = filedialog.asksaveasfilename()
            if filename:
                current_file_path = filename
                name = os.path.basename(filename)  # Get only the filename
                self.filename_text.configure(state=tk.NORMAL)
                self.filename_text.delete(1.0, tk.END)
                self.filename_text.insert(tk.END, name)
                self.filename_text.configure(state=tk.DISABLED)
                with open(filename, 'w') as file:
                    file.write(self.text_editor.get("1.0", "end-1c"))

    """ compile_file
        Save the file and execute the assembler.py program to generate the .hex file
    """
    def compile_file(self):
        global current_file_path  # Access the global variable
        filename = self.filename_text.get("1.0", "end-1c").strip() # Get current file name
        name = os.path.splitext(os.path.basename(filename))[0]  # Get only the filename
        if not filename:
            filename = filedialog.asksaveasfilename()
            if not filename:
                return  # User cancelled save operation
            current_file_path = filename
            name = os.path.splitext(os.path.basename(filename))[0]  # Get only the filename
            self.filename_text.configure(state=tk.NORMAL)
            self.filename_text.delete(1.0, tk.END)
            self.filename_text.insert(tk.END, filename)
            self.filename_text.configure(state=tk.DISABLED)

        # Execute assembler.py with appropriate arguments
        #subprocess.run(["python", "ASSEMBLER/assembler.py", "-i", current_file_path, "-o", name + ".hex"], capture_output=True)
        
        try:
            # Execute assembler.py with appropriate arguments
            subprocess.run(["python", "ASSEMBLER/assembler.py", "-i", current_file_path, "-o", name + ".hex"], check=True)
            messagebox.showinfo("Compilation Successful", "The file has been compiled successfully.")
        except subprocess.CalledProcessError:
            messagebox.showerror("Compilation Error", "An error occurred during compilation. Please check the assembler script.")


    """ write_code
        Send .hex File to the UART to write the instructions into the instruction memory
    """
    def write_code(self):
        # Replace this with actual code to send code through UART
        print("Sending code through UART")

    """ run_code
        Send "run" code to the UART to execute the code, and wait for "halt" code
    """
    def run_code(self):
        # Replace this with actual code to send code through UART and receive the result
        print("Sending run command through UART")
        print("Waiting for halt code...")
        # Placeholder for updating 32 registers, 32 memory positions, and Program Counter
        registers_values = ["Value{}".format(i) for i in range(32)]
        memory_values = ["Value{}".format(i) for i in range(32)]
        program_counter_value = "Value"
        self.update_table(self.registers_text, registers_values)
        self.update_table(self.memory_text, memory_values)
        self.pc_value_label.config(text="Program Counter: {}".format(program_counter_value))

    def update_table(self, text_widget, values):
        text_widget.configure(state=ctk.NORMAL)
        text_widget.delete('1.0', ctk.END)
        for value in values:
            text_widget.insert(ctk.END, value + '\n')
        text_widget.configure(state=ctk.DISABLED)

    def update_register_memory(self):
        # Placeholder for updating registers and memory values periodically
        registers_values = ["Value{}".format(i) for i in range(32)]
        memory_values = ["Value{}".format(i) for i in range(32)]
        self.update_table(self.registers_text, registers_values)
        self.update_table(self.memory_text, memory_values)
        self.after(1000, self.update_register_memory)

if __name__ == "__main__":
    app = IDE()
    app.mainloop()
