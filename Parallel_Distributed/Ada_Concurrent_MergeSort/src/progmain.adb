with Ada.Text_IO, Ada.Command_Line, GNAT.String_Split, Sort;  

procedure Progmain is
    newArray: Sort.Int_Array;
    temp_array: Sort.Int_Array := (others => 0);
    s: Integer := 0;

    task type Sum is
        entry start_output;
    end Sum;
    task body Sum is
    begin
        accept start_output;
        for i in Integer range 1 .. Sort.SIZE loop
            s := s + newArray(i);
        end loop;
        Ada.Text_IO.Put_Line("The sum of the array is: " & Integer'Image(s));
    end Sum;

    task type Printer is
        entry start_output;
    end Printer;
    task body Printer is
    begin
        accept start_output;
        Ada.Text_IO.Put_Line("The Array is shown below:");
        for i in Integer range 1 .. Sort.SIZE loop
            Ada.Text_IO.Put(Integer'Image(newArray(i)));
            if i /= Sort.Size then
                Ada.Text_IO.Put(",");
            end if;
        end loop;
    end Printer;

    Task_sum: Sum;
    Task_print: Printer;

    task type runSort is
        entry start_sort;
    end runSort;
    task body runSort is
    begin
        accept start_sort;
        Sort.MergeSort(newArray, temp_array, 1, Sort.SIZE);
        Task_sum.start_output;
        Task_print.start_output;
    end runSort;

    Task_sort: runSort;

    task type Reader is
        entry start_read;
    end Reader;
    task body Reader is
        FileName: string := Ada.Command_Line.Argument(1);
        InFile: Ada.Text_IO.File_Type;
        LineCount: Integer := 0;
        NumberCount: Integer := 0;
        subs: GNAT.String_Split.Slice_Set;
        seps: constant String := " ";
    begin
        accept start_read;
        Ada.Text_IO.Put_Line("The input file is: " & FileName);
        Ada.Text_IO.Open(File => InFile, 
                         Mode => Ada.Text_IO.In_File, 
                         Name => FileName);
        while not Ada.Text_IO.End_Of_File (InFile) loop
            declare
                Line: String := Ada.Text_IO.Get_Line (InFile);
            begin
                LineCount := LineCount + 1;
                GNAT.String_Split.Create (S             => subs,
                                          From          => Line,
                                          Separators    => seps,
                                          Mode          => GNAT.String_Split.Multiple);
                
                for i in 1 .. GNAT.String_Split.Slice_Count (subs) loop
                    declare
                        Sub: String := GNAT.String_Split.Slice (subs, i);
                    begin
                        NumberCount := NumberCount + 1;
                        newArray(NumberCount) := Integer'Value(Sub);
                    end;
                end loop;
            end; 
        end loop;
        Ada.Text_IO.Close (InFile);
        Task_sort.start_sort;
    end Reader;

    Task_read: Reader;
  
begin
    Task_read.start_read;
end progmain; 
        

        


