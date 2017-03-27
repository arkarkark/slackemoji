emojiimg = document.getElementById("emojiimg")
emojiname = document.getElementById("emojiname")

if emojiimg
  emojiimg.addEventListener "change", (event) ->
    document.querySelector("input.btn.btn_primary").focus()
    return if emojiname.value # do not change existing value
    newName = emojiimg.files[0].name
      .replace(/\.[^.]*$/, "") # strip extension
      .replace(/[^\w]+/g, "-") # convert non-ascii chars to -
      .replace(/[_]+/g, "-")   # convert _ to -
      .replace(/^-+|-+$/g, "") # trim - from start and end
      .toLowerCase()
    emojiname.value = newName if newName
