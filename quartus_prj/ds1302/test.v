

//校时
if(Value_en && !en && KEY_Value == 4'd1)
begin
    write_hour <= write_hour + 1;
end
else if(Value_en && !en && KEY_Value == 4'd2)
begin
    write_minute <= write_minute + 1;
end
else if(Value_en && !en && KEY_Value == 4'd3)
begin
    write_second <= write_second + 1;
end

