use Amnesia

defdatabase PasteDB do
  deftable Paste, [ :id, :title, :public, :ircchannels, :date, :expires, :previous_version, :content], type: :ordered_set do end
end
