package Sort is
    SIZE: constant Integer := 40;
    subtype Small_Int is Integer range -500 .. 500;
    type Int_Array is array(1 .. SIZE) of Small_Int;
    procedure MergeSort(InArray, tmpArray: in out Int_Array; start1, end1: in Integer);
end Sort;
