package body Sort is
    procedure MergeSort(InArray, tmpArray: in out Int_Array; start1, end1: in Integer) is
        procedure runTasks(InArray, tmpArray: in out Int_Array; first, last: in Integer) is
            task type run_left;
            task body run_left is
            begin
                MergeSort(InArray, tmpArray, first, (first+last)/2);
            end run_left;

            task type run_right;
            task body run_right is
            begin
                MergeSort(InArray, tmpArray, (first+last)/2+1, last);
            end run_right;

            Task_left: run_left;
            Task_right: run_right;
        begin
            null;
        end runTasks;
        
        procedure Merge(InArray, tmpArray: in out Int_Array; first, last: in Integer) is
            mid, index1, index2, k: Integer;
        begin
            mid := (first + last) / 2;
            index1 := first;
            index2 := mid + 1;
            k := first;
            while (index1 /= mid+1) and (index2 /= last+1) loop
                if InArray(index1) <= InArray(index2) then
                    tmpArray(k) := InArray(index1);
                    k := k + 1;
                    index1 := index1 + 1;
                else
                    tmpArray(k) := InArray(index2);
                    k := k + 1;
                    index2 := index2 + 1; 
                end if;
            end loop;

            if index1 < mid+1 then
                while (index1 /= mid+1) loop
                    tmpArray(k) := InArray(index1);
                    k := k + 1;
                    index1 := index1 + 1;
                end loop;
            end if;
            
            if index2 < last+1 then
                while (index2 /= last +1) loop
                    tmpArray(k) := InArray(index2);
                    k := k + 1;
                    index2 := index2 + 1;
                end loop;
            end if;

            for i in Integer range first .. last loop
                InArray(i) := tmpArray(i);
            end loop;
        end Merge;   
    begin
        if start1 /= end1 then
            runTasks(InArray, tmpArray, start1, end1);
            Merge(InArray, tmpArray, start1, end1); 
        end if;
    end MergeSort;
end Sort;   

