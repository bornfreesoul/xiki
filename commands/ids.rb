class Ids
  def self.menu *args

Ol()

    # If just "ids/", list all...

    if args.blank?
      js = %`
        var result="";
        $('*[id]').each(function(i, e){
          var id = $(e).attr('id');
          result += "+ #"+id+"/\\n";
        })
        result;
        `.unindent

Ol.a js
      result = Firefox.exec js
      return "
        > No id attributes found in page!
        | Maybe try listing by classes:
        << css/list/
        " if result == '""'
      return result
    end

    # Id passed so just navigate to it...

Ol "args", args   # => ["#hi", "new text\n"]
  # => ["#hi"]

    # return "todo"
    Xiki["dom", args]

  end
end
