defmodule PasteDBTest do
  use ExUnit.Case
  require Amnesia

  test "Paste Create and Read match!" do
    date = Timex.Date.now(:secs)
    expires = date + 60
    publictemplate = %PasteDB.Paste{title: "Public Test Title", public: true, ircchannels: [], date: date, expires: expires, previous_version: nil, content: "Public Test Content"}
    privatetemplate = %PasteDB.Paste{title: "Public Test Title", public: false, ircchannels: [], date: date, expires: expires, previous_version: nil, content: "Public Test Content"}

    publicid  = Pastenix.Paste.create(publictemplate)
    privateid = Pastenix.Paste.create(privatetemplate)

    returnedpublic = Pastenix.Paste.fetch(publicid)
    returnedprivate = Pastenix.Paste.fetch(privateid)

    assert(returnedpublic  == %{publictemplate | id: publicid})
    assert(returnedprivate == %{privatetemplate | id: privateid})

  end

  test "Test Paste Edit" do
    date = Timex.Date.now(:secs)
    expires = date + 60

    originaltemplate = %PasteDB.Paste{title: "Public Test Title", public: true, ircchannels: [], date: date, expires: expires, previous_version: nil, content: "Public Test Content"}

    originaluuid = Pastenix.Paste.create(originaltemplate)
    returnedrecord = Pastenix.Paste.fetch(originaluuid)

    ## Let's modify some dataz
    newuuid = %{returnedrecord | title: "Modified the title", ircchannels: [:irc1], content: "Modified content"}
    |> Pastenix.Paste.edit

    newrecord = Pastenix.Paste.fetch(newuuid)

    assert(returnedrecord.previous_version == nil)
    assert(returnedrecord.id == newrecord.previous_version)
    assert(returnedrecord.title == "Public Test Title")
    assert(returnedrecord.ircchannels == [])
    assert(newrecord.title == "Modified the title")
    assert(newrecord.ircchannels == [:irc1])
    assert(newrecord.content == "Modified content")
  end

end
