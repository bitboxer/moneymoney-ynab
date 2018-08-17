Exporter{version       = 1.00,
         format        = "YNAB CSV file",
         fileExtension = "csv",
         description   = "Export as YNAB compatible CSV file"}

local function csvField (str)
  if str == nil then
    return ""
  elseif string.find(str, ";") then
    return '"' .. string.gsub(str, '"', '""') .. '"'
  else
    return str
  end
end

function WriteHeader (account, startDate, endDate, transactionCount)
  assert(io.write("Account;Date;Payee;Category;Memo;Outflow;Inflow;\n"))
end

function WriteTransactions (account, transactions)
  for _,transaction in ipairs(transactions) do
    inflow = 0;
    outflow = 0;
    if (transaction.amount >= 0) then
        outflow = transaction.amount
    else
        inflow = transaction.amount * -1
    end

    assert(io.write(
        csvField(account.name) .. ";" ..
        csvField(MM.localizeDate("dd/MM/yyyy", transaction.bookingDate)) .. ";" ..
        csvField(transaction.name) .. ";" ..
        csvField(transaction.category) .. ";" ..            
        csvField(transaction.purpose) .. ";" ..
        csvField(inflow) .. " " .. transaction.currency .. ";" ..
        csvField(outflow) .. " " .. transaction.currency .. ";" .. "\n"))
  end
end

function WriteTail (account)
end