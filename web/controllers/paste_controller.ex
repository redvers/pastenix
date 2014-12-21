
defmodule Pastenix.Controller.Paste do
  use Phoenix.Controller
  plug :action
             
  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, %{"pastetext" => content, "title" => title, "permissions" => perms}) do
    uuid = Pastenix.Paste.create(%PasteDB.Paste{date: Timex.Date.now(:secs), content: content, title: title, public: is_public?(perms)}) 
    redirect conn, to: "/paste/" <> uuid
  end

  def fetch(conn, %{"id" => id}) do
    pasterecord = Pastenix.Paste.fetch(id)
    render conn, "show.html", %{paste: pasterecord}
  end

  def edit(conn, %{"id" => id, "pastetext" => content, "title" => title, "permissions" => perms}) do
    uuid = Pastenix.Paste.edit(%PasteDB.Paste{id: id, date: Timex.Date.now(:secs), content: content, title: title, public: is_public?(perms)})
    redirect conn, to: "/paste/" <> uuid
  end



  defp is_public?("public") do
    true
  end

  defp is_public?("private") do
    false
  end
    

end
