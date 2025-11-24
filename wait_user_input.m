
function status = wait_user_input(MSG, NoThrow)
    arguments
        MSG string
        NoThrow string {mustBeMember(NoThrow, ...
            ["NoThrow", "Produce_Error"])} = "Produce_Error";
    end

    stop = false;
    while ~stop
        disp('----------------')
        disp(MSG)
        in = input('Proceed?(y/n) ', 's');
        if in == "y"
            stop = true;
            status = true;
        elseif in == "n"
            status = false;
            stop = true;
            if NoThrow == "Produce_Error"
                error('program closed by user');
            end
        end
    end

end



