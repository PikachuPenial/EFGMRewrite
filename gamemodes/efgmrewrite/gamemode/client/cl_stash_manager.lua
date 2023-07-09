
-- keeps up with the client's stash information, to limit desync, improve sorting capabilities, and its gonna use sql you already know
-- i asked chatgpt if having a client-side copy of the stash (with caveats like only your shit etc) was a good idea, and they
-- gave me god's most generic fucking answer, so ima assume thats a yes

concommand.Add("efgm_transaction_stash", function(ply, cmd, args)

    net.Start("RequestTransactionStash", false)
    net.WriteTable(args)
    net.SendToServer()

end)