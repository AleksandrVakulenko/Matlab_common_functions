

function [Str, Value_out, Err_out] = err_str(Value, Err, SI_unit)
arguments
    Value
    Err
    SI_unit = ''
end
    [Value, Err] = round2err(Value, Err);
    Value_out = Value;
    Err_out = Err;

    [Value, Exp_V, Unit_pref_V] = si_shift(Value);
    
    Err_init = Err;
    [Err, Exp_E, Unit_pref_E] = si_shift(Err);
    
    
    if Exp_E > Exp_V - 5
        Two_prefix = false;
        [Err, ~, Unit_pref_E] = si_shift(Err_init, Exp_V);
    else
        Two_prefix = true;
    end
    
    
    if Two_prefix
    Str = [num2str(Value) ' ' Unit_pref_V SI_unit ' (± ' num2str(Err) ...
        ' ' Unit_pref_E SI_unit ')'];
    else
        Str = ['(' num2str(Value) ' ± ' num2str(Err) ') ' Unit_pref_V SI_unit];
    end
end


function [Value, Exp, Unit_pref] = si_shift(Value, Exp)
arguments
    Value
    Exp = []
end
    if isempty(Exp)
        Nv = lead_digit_pos(Value);
        log_shift = mod(Nv, 3) - Nv;
        Value = Value * 10.^log_shift;
        Exp = -log_shift;
    else
        log_shift = -Exp;
        Value = Value * 10.^log_shift;
    end
    
    if abs(Exp) > 15 || mod(Exp, 3) ~= 0
        Unit_pref = ['E' num2str(Exp, '%+0.0f')];
    else
        switch Exp
            case 15
                Unit_pref = 'P';
            case 12
                Unit_pref = 'T';
            case 9
                Unit_pref = 'G';
            case 6
                Unit_pref = 'M';
            case 3
                Unit_pref = 'k';
            case 0
                Unit_pref = '';
            case -3
                Unit_pref = 'm';
            case -6
                Unit_pref = 'u';
            case -9
                Unit_pref = 'n';
            case -12
                Unit_pref = 'p';
            case -15
                Unit_pref = 'f';
            otherwise
                error("unreachable")
        end
    end
end


function [Value, Err] = round2err(Value, Err)
    Nv = lead_digit_pos(Value);
    Ne = lead_digit_pos(Err);
    
    % NOTE: if error is too big - show Value with 2/3 digits
    if Ne > Nv
        Nv = Nv - 3;
        Ne = Nv;
    elseif Ne == Nv
        Nv = Nv - 2;
        Ne = Nv;
    end
    
    Value = round2digit(Value, Ne);
    Err = round2digit(Err, Ne-1);
end


function Value = round2digit(Value, N)
    Value = round(Value/10^N)*10^N;
end


function N = lead_digit_pos(Value)
% FIXME: Value == inf OR NaN
    if Value == 0
        N = 0;
    else
        N = floor(log10(abs(Value)));
    end
end




