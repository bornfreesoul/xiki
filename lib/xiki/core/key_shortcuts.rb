module Xiki
  class KeyShortcuts

    # Define all keys
    def self.keys

      Menu.init

      # Keys.accumulate do
      self.as_keys
      self.open_keys
      self.write_keys
      self.hop_keys
      self.tile_keys
      self.run_keys
      self.jump_keys
      self.search_keys   # time > (0.073769)
      self.misc   # time > (0.0451)

    end

    def self.as_keys

      # This breaks > probably unset C-a first, so we can go back to this

      Xiki.def("as+save", :noob=>1){ DiffLog.save }

      Xiki.def("as+command"){ Menu.as_menu }
      Xiki.def("as+bookmark", :noob=>1){ Bookmarks.save }

      Xiki.def("as+line"){ Clipboard.as_line }
      Xiki.def("as+paragraph"){ Clipboard.copy_paragraph }   # copy paragraph
      Xiki.def("as+rest"){ Clipboard.copy_paragraph(:rest => true) }
      Xiki.def("as+unsaved", :noob=>1){ DiffLog.compare_with_saved }
      Xiki.def("as+all"){ Clipboard.copy_everything }
      Xiki.def("as+directory"){ FileTree.copy_path }   # copy dir to clipboard from tree

      Xiki.def("as+task"){ Notes.as_todo }
      Xiki.def("as+files", :noob=>1){ Notes.as_file }   # Save in :f

      Xiki.def("as+here"){ Location.as_spot }   # remember point in file
      Xiki.def("as+version"){ History.backup_file }   # creates backup
      Xiki.def("as+indented"){ CodeTree.as_indented }
      Xiki.def("as+macro"){ Macros.record }   # start recording macro

      # Todo > remove as+open after dropdown items supercede it (in notes, etc.)?
      #   Wait > these may be 2 distinct cases (think about :f)
      #     as+open may still be needed, like when you want to open a file from :f, but it has an outline underneath that you don't want to close
      Xiki.def("as+open"){ Launcher.as_open }
      Xiki.def("as+expand"){ Launcher.as_open }

      Xiki.def("as+you"){ Clipboard.as_thing }   # copy object / symbol at point

      Xiki.def("as+name+before"){ Clipboard.copy("1") }   # copy object / symbol at point
      Xiki.def("as+name+after"){ Clipboard.copy("2") }   # copy object / symbol at point

      # Y
      # Z
    end


    def self.open_keys
      # O: open...
      # Use O prefix for: opening, jumping to files

      Xiki.def("open+file", :noob=>1){ Bookmarks.go }
      Xiki.def("open+untitled", :noob=>1){ View.new_file }
      Xiki.def("open+views", :noob=>1){ Launcher.open("views/") }
      Xiki.def("open+quotes"){ Launcher.open("views/", :dropdown=>["quoted"]) }

      Xiki.def("open+help", :noob=>1){ Launcher.open("help/", :letter=>1) }   # OO - open line (O's emacs default)

      Xiki.def("open+command"){ Launcher.open_command }
      Xiki.def("open+prompt", :noob=>1){ Launcher.open_prompt }

      Xiki.def("open+edited"){ Files.open_edited }   # show recently edited files
      Xiki.def("open+recent", "recent files/")
      Xiki.def("open+diffs"){ DiffLog.open }   # shows diffs of what you've edited

      Xiki.def("open+tasks", :noob=>1){ Notes.open_tasks }   # shows diffs of what you've edited
      Xiki.def("open+notes", :noob=>1){ Notes.open_note }
      Xiki.def("open+bookmarks"){ Launcher.open "bookmarks/" }

      Xiki.def("open+sessions", :noob=>1){ Launcher.open "sessions/" }
      Xiki.def("open+ordered"){ Bookmarks.go nil, :date_sort=>true }

      Xiki.def("open+key"){ Keys.jump_to_code }   # jump to ruby code of key definition
      Xiki.def("open+whereabouts"){ Code.do_list_ancestors }

      # G: leave unmapped for escape

      Xiki.def("open+list+bookmarks"){ Launcher.open("This is currently broken - re-do > was > bookmarks/list/") }   # list

      Xiki.def("open+list+faces"){ Styles.list_faces }   # list

      Xiki.def("open+as+outlog"){ OlHelper.open_last_outlog }   # last

      Xiki.def("open+list+urls"){ Launcher.open "last/urls/" }   # last

      Xiki.def("open+in+browser"){ Browser.open_in_browser }
      Xiki.def("open+in+left"){ View.open_in_bar }
      Xiki.def("open+in+os"){ Files.open_in_os }
      Xiki.def("open+in+window"){ Files.open_in_window }   # Expose file in OS folder


      Xiki.def("open+as+calendar"){ $el.calendar }
      Xiki.def("open+as+file"){ Code.open_as_file }
      Xiki.def("open+as+elisp"){ $el.find_function_at_point }   # jump to definition of lisp function
      Xiki.def("open+as+highest"){ FileTree.open_as_upper }
      Xiki.def("open+as+lowest"){ FileTree.open_as_upper(:lowest) }
      Xiki.def("open+as+utf"){ $el.revert_buffer_with_coding_system('utf-8'.to_sym) }
      Xiki.def("open+as+2"){ FileTree.open_as_upper(:second) }
      Xiki.def("open+as+root"){ Files.open_sudo }
      Xiki.def("open+as+shell"){ Shell.open }
      Xiki.def("open+as+tail"){ Files.open_tail }
      Xiki.def("open+as+remote"){ Remote.save_file }

      Xiki.def("open+xiki+docs"){ Help.display_docs }
      # Y
      # Z

      Xiki.def("open+1"){ Files.open_nth 1 };  Xiki.def("open+2"){ Files.open_nth 2 };  Xiki.def("open+3"){ Files.open_nth 3 };  Xiki.def("open+4"){ Files.open_nth 4 };  Xiki.def("open+5"){ Files.open_nth 5 }
      Xiki.def("open+6"){ Files.open_nth 6 };  Xiki.def("open+7"){ Files.open_nth 7 };  Xiki.def("open+8"){ Files.open_nth 8 };  Xiki.def("open+9"){ Files.open_nth 9 }

      Xiki.def("open+0"){ Files.open_nth 0 }   # Open 0: open line in :f that cursor is on

      Xiki.def("open+8"){ History.open_current :all => true, :prompt_for_bookmark => true }   # Like do_outline, but inserts all
    end


    def self.write_keys
      # E: enter...
      # Use E prefix for: inserting

      Xiki.def("write+bullet"){ Notes.bullet }   # Commit to repos, push, etc
      Xiki.def("write+command"){ Launcher.insert_menu }
      Xiki.def("write+whitespace"){ Code.enter_whitespace }

      Xiki.def("write+row"){ View.insert_line }
      Xiki.def("write+junior"){ Notes.enter_junior }
      Xiki.def("write+search"){ Search.enter_insert_search }

      Xiki.def("write+note"){ Notes.enter_note }
      Xiki.def("write+key"){ Keys.insert_code }
      Xiki.def("write+url"){ Firefox.enter_as_url }

      Xiki.def("write+history"){ View << "$"; Launcher.launch }
      Xiki.def("write+tasks"){ View.enter_upper }
      Xiki.def("write+file"){ Files.enter_file }   # in tree, enter methods or headings
      Xiki.def("write+outline"){ Launcher.enter_outline }   # in tree, enter methods or headings

      Xiki.def("write+quote"){ FileTree.enter_quote }
      Xiki.def("write+pipe"){ FileTree.enter_quote nil, :char=>"|" }
      Xiki.def("write+multi"){ $el.cua_set_rectangle_mark }
      Xiki.def("write+insert+replacement"){ Search.insert_before_and_after }

      Xiki.def("write+insert+comment"){ Code.enter_insert_comment }      # insert date string (and time if C-u)

      Xiki.def("write+insert+time"){ Line.insert_time }
      Xiki.def("write+insert+date"){ Line.insert_date }

      Xiki.def("write+insert+http"){ View << "http://" }
      Xiki.def("write+insert+new"){ DiffLog.enter_new }           # Enter Old: enter newly-deleted from last save
      Xiki.def("write+insert+old"){ DiffLog.enter_old }   # Enter Old: enter newly-deleted from last save
      Xiki.def("write+insert+ruby"){ code = Keys.input(:prompt=>"Enter ruby code to eval and insert results: "); View.insert(eval(code).to_s)}

      Xiki.def("write+log+javascript"){ Firefox.enter_log_javascript_line }   # Xiki.def("write+log+javascript"){ Firefox.enter_log_javascript_line }
      Xiki.def("write+log+stack"){ Code.enter_log_stack }   # Xiki.def("write+log+stack"){ Code.enter_log_stack }
      Xiki.def("write+log+line"){ Code.enter_log_line }   # Xiki.def("write+log+line"){ Code.enter_log_line }
      Xiki.def("write+log+exclamation"){ Code.enter_log_line :exclamation=>1 }   # Xiki.def("write+log+line"){ Code.enter_log_line }

      Xiki.def("write+log+time"){ Code.enter_log_time }   # Xiki.def("write+log+time"){ Code.enter_log_time }

    end


    def self.jump_keys

      Xiki.def("jump+line"){ Move.to_line }
      Xiki.def("jump+file"){ FileTree.tree :recursive=>1 }

      Xiki.def("jump+outline"){ History.open_current :outline=>true, :prompt_for_bookmark=>true }
      Xiki.def("jump+unsaved"){ Launcher.open("unsaved/") }
      Xiki.def("jump+related+test"){ Code.open_related_rspec }
      Xiki.def("jump+related+file"){ Code.open_related_file }

      Xiki.def("jump+move+file"){ Launcher.open("Todo > Find method that moves the current file...", :no_launch=>1) }
      Xiki.def("jump+move+here"){ FileTree.move_to }
      Xiki.def("jump+move+copy"){ FileTree.copy_to }

      Xiki.def("jump+yours"){ FileTree.copy_to }

      Xiki.def("jump+status"){ Git.do_status }
      Xiki.def("jump+diff"){ Git.do_push }   # Commit to repos, push, etc

      Xiki.def("jump+command"){ Launcher.open_nested_command }
      Xiki.def("jump+prompt"){ Shell.prompt_for_bookmark }

      Xiki.def("jump+history"){ Shell.history_for_bookmark }

      (1..9).each do |n|
        Xiki.def("jump+#{n}"){ View.to_nth_fraction n }
      end

    end


    def self.run_keys
      # D: do...
      # Use D prefix for: things that modify text or execute code

      Xiki.def("run+remove"){ Deletes.backward }
      Xiki.def("run+macro"){ Macros.run }   # do last macro
      Xiki.def("run+task"){ Launcher.do_task }
      Xiki.def("run+up"){ Launcher.do_last_launch :here=>1 }

      Xiki.def("run+indent"){ Code.indent_to }
      Xiki.def("run+comment"){ Code.comment }
      Xiki.def("run+eval"){ Code.run }   # run code as ruby
      Xiki.def("run+omit"){ Deletes.forward }
      Xiki.def("run+kill"){ Clipboard.kill }
      Xiki.def("run+highlight"){ Color.run_highlight }


      Xiki.def("run+query"){ Search.query_replace }   # do query replace

      Xiki.def("run+version+next"){ DiffLog.compare_views }
      Xiki.def("run+version+here"){ DiffLog.compare_in_tree }

      Xiki.def("run+version+repository"){ Git.do_compare_repository }
      Xiki.def "run+version+log", ".=git/log/"   # Show git diffs of current file

      Xiki.def("run+version+backups"){ History.list }   # Show all backed-up versions
      Xiki.def("run+version+previous"){ History.diff_with_backup }   # compare with last AV version
      Xiki.def("run+version+edits"){ Launcher.open("#{View.file}\n  =edits/") }

      Xiki.def("run+as+align"){ Code.do_code_align }   # Based on input character, all matches line up
      Xiki.def("run+as+execute"){ Shell.do_as_execute }   # Run shell command on tree
      Xiki.def("run+as+html"){ Firefox.do_as_html }
      Xiki.def("run+as+browser"){ Firefox.exec_block }
      Xiki.def("run+as+javascript"){ Javascript.run }
      Xiki.def("run+as+command"){ Menu.do_as_menu }   # Grab item after '@' and run it by itself
      Xiki.def("run+as+outline"){ Menu.do_as_outline }   # Grab item after '@' and run it by itself
      Xiki.def("run+as+python"){ Python.run }

      Xiki.def("run+as+space"){ Code.add_space }
      Xiki.def("run+as+test"){ Code.do_as_rspec }
      Xiki.def("run+as+wrap"){ Block.do_as_wrap }
      Xiki.def("run+as+quote"){ Notes.do_as_quote }
      Xiki.def("run+as+xul"){ Firefox.do_as_xul }
      Xiki.def("run+as+deck"){ Deck.enable_arrow_keys }

      Xiki.def("run+delete+all"){ Effects.blink :what=>:all; View.kill_all }   # kill all text in buffer

      Xiki.def("run+delete+indented"){ CodeTree.do_kill_indented }
      Xiki.def("run+delete+siblings"){ CodeTree.kill_siblings }   # kill adjacent lines at same indent as this one
      Xiki.def("run+delete+trailing"){ View.gsub!(/[ 	]+$/, "") }   # Deletes trailing whitespace

      Xiki.def("run+delete+current"){ Files.delete_current_file }
      Xiki.def("run+delete+unsaved"){ Files.do_load_file }

      Xiki.def("run+delete+matching"){ Search.kill_filter }
      Xiki.def("run+delete+nonmatching"){ Search.kill_filter }

      Xiki.def("run+lines+duplicate"){ Line.duplicate }

      Xiki.def("run+lines+browser"){ Browser.reload }
      Xiki.def("run+lines+command"){ Shell.do_last_command }
      Xiki.def("run+lines+having"){   # delete lines matching a regex
        unless $el.elvar.current_prefix_arg
          $el.delete_matching_lines( Keys.input(:prompt => "Delete lines having: ") )
        else
          $el.delete_non_matching_lines( Keys.input(:prompt => "Delete lines not having: ") )
        end
      }
      Xiki.def("run+lines+jumble"){ Code.randomize_lines }   # Shuffle lines
      Xiki.def("run+lines+linux"){ $el.set_buffer_file_coding_system :unix }
      Xiki.def("run+lines+next"){ Line.move :next }
      Xiki.def("run+lines+previous"){ Line.move(:previous) }
      Xiki.def("run+lines+reverse"){ $el.reverse_region($el.region_beginning, $el.region_end) }
      Xiki.def("run+lines+sort"){ Line.do_lines_sort }

      Xiki.def("run+lines+toggle"){ Line.do_lines_toggle }   # Swap next N lines

      Xiki.def("run+lines+unique"){ Code.kill_duplicates }   # Uniqify, delete duplicates
      Xiki.def("run+lines+windows"){ $el.set_buffer_file_coding_system :dos }
      Xiki.def("run+jump+up"){ FileTree.move_up }

      Xiki.def("run+name+view"){ Buffers.rename }
      Xiki.def("run+name+enter"){ Incrementer.enter }
      Xiki.def("run+name+increment"){ Incrementer.increment }
      Xiki.def("run+name+one"){ Incrementer.start }

      Xiki.def("run+1"){ Launcher.do_last_launch :nth=>1 }
      Xiki.def("run+2"){ Launcher.do_last_launch :nth=>2 }
      Xiki.def("run+3"){ Launcher.do_last_launch :nth=>3 }
      Xiki.def("run+4"){ Launcher.do_last_launch :nth=>4 }
      Xiki.def("run+5"){ Launcher.do_last_launch :nth=>5 }
      Xiki.def("run+6"){ Launcher.do_last_launch :nth=>6 }
      Xiki.def("run+7"){ Launcher.do_last_launch :nth=>7 }

    end


    def self.hop_keys
      # Use H prefix for: moving cursor, jumping to specific points

      Xiki.def("hop+left", :noob=>1){ Move.hop_left_key }   # to beginning of file
      Xiki.def("hop+right", :noob=>1){ Move.hop_right_key }   # To end of line
      Xiki.def("hop+top", :noob=>1){ View.to_highest }
      Xiki.def("hop+bottom", :noob=>1){ View.to_bottom }   # move to end

      Xiki.def("hop+up"){ View.page_up }
      Xiki.def("hop+down"){ View.page_down }
      Xiki.def("hop+next"){ Move.to_next_paragraph }   # to next paragraph
      Xiki.def("hop+previous"){ Move.to_previous_paragraph :skip_if_top=>1 }   # to beginning of previous paragraph

      Xiki.def("hop+search"){ Search.outline_search }
      Xiki.def("hop+outline", :noob=>1){ FileTree.to_outline }   # OO - open line (O's emacs default)
      Xiki.def("hop+indent"){ Move.to_indent }
      Xiki.def("hop+junior"){ Move.to_junior }

      # hop+climb is a possible alternative
      Xiki.def("hop+ascend"){ Tree.to_parent }   # to parent (last line indented less)

      Xiki.def("hop+here"){ Location.to_spot }
      Xiki.def("hop+command"){ Menu.to_menu }
      Xiki.def("hop+kind"){ Move.to_other_bracket }   # to matching bracket, etc

      Xiki.def("hop+quote"){ Move.to_quote }   # move to next ...|... quote

      Xiki.def("hop+middle"){ View.to_relative }   # go to nth line, relative to top of window (up+ for middle, up+up+ for bottom)
      Xiki.def("hop+edge"){ View.to_relative :line=>1 }   # go to nth line, relative to top of window (up+ for middle, up+up+ for bottom)
      Xiki.def("hop+words"){ Line.to_beginning }   # move to start of words on line
      # X
      # Z

      (1..9).each do |n|
        Xiki.def("hop+#{n}"){ View.to_nth_paragraph n }
      end

    end

    def self.tile_keys
      # Use for: adjusting the layout, changing what is visible

      Xiki.def("tile+create"){ View.create }

      Xiki.def("tile+hide"){ View.hide }
      Xiki.def("tile+delete"){ View.kill }

      Xiki.def("tile+next"){ View.next(:blink=>true) }
      Xiki.def("tile+previous"){ View.previous(:blink=>true) }



      Xiki.def("tile+edge"){ View.recenter_top_key }
      Xiki.def("tile+alone"){ View.hide_others }
      Xiki.def("tile+bigger"){ View.enlarge }
      Xiki.def("tile+middle"){ View.recenter }   # LL - recenter (L's emacs default)

      Xiki.def("tile+tasks"){ View.layout_todo }   # show bar on left with the quick bookmark named "-t"
      Xiki.def("tile+files"){ View.layout_files }
      Xiki.def("tile+outlog"){ View.layout_outlog }
      Xiki.def("tile+uniform"){ 3.times { View.balance } }

      Xiki.def("tile+wrap"){ $el.toggle_truncate_lines }   # wrap lines

      Xiki.def("tile+jump"){ View.shift }

      Xiki.def("tile+select"){ Clipboard.select }

      Xiki.def "tile+kind", "tile settings/", :letter=>1   # Used to be +visible
      Xiki.def("tile+vertical"){ View.create_vertical }

      # Q
      Xiki.def("tile+indent"){ Hide.hide_by_indent }   # only show lines indented less than x
      Xiki.def("tile+right"){ View.to_upper(:blink=>true) }
      # X
      # Y
      Xiki.def("tile+zoom"){ View.zoom }   # show selection only

      Xiki.def("tile+1"){ Move.to_window(1, :blink=>true) }
      Xiki.def("tile+2"){ Move.to_window(2, :blink=>true) }
      Xiki.def("tile+3"){ Move.to_window(3, :blink=>true) };  Xiki.def("tile+4"){ Move.to_window(4, :blink=>true) }
      Xiki.def("tile+5"){ Move.to_window(5, :blink=>true) };  Xiki.def("tile+6"){ Move.to_window(6, :blink=>true) };  Xiki.def("tile+7"){ Move.to_window(7, :blink=>true) };  Xiki.def("tile+8"){ Move.to_window(8, :blink=>true) }
      Xiki.def("tile+9"){ Move.to_last_window(:blink=>true) }
      Xiki.def("tile+0"){ View.recenter_top }   # Layout 0: scroll so cursor is 0 lines from top af window

    end


    def self.search_keys

      Xiki.def("search+copy"){ Search.isearch_copy }   # Clipboard (copy) (or search+commands if no search)
      Xiki.def("search+xut"){ Search.xiki }   # search+xiki+__ mapped inside this method
      Xiki.def("search+kill"){ Search.isearch_clear }   # cut (or search at point of last cut, if no search)

      Xiki.def("search+value"){ Search.insert_at_search_start }   # Value: copy value back to search start
      Xiki.def("search+pull"){ Search.isearch_pull }   # Pull back to search start (or search+push if nothing searched for yet)
      Xiki.def("search+zap"){ Search.zap }   # zap - delete up until search start

      Xiki.def("search+tasks"){ Search.isearch_tasks }   # To: open file / jump to method
      Xiki.def("search+files"){ Search.bookmark }   # when no search, prompt for input
      Xiki.def("search+outline"){ Search.isearch_outline }   # Outline (or search+outlog if nothing searched for yet)

      Xiki.def("search+next"){ Search.isearch_after }
      Xiki.def("search+usurp"){ Search.isearch_pull_in_sexp }   # usurp: pull sexp into search string

      Xiki.def("search+before"){ Search.isearch_or_copy("1") }
      Xiki.def("search+after"){ Search.isearch_or_copy("2") }


      Xiki.def("search+expand"){ Search.expand }   # Stop and just expand the line
      Xiki.def("search+dropdown"){ Search.isearch_diffs }   # Delete (or search+difflog if no search)
      Xiki.def("search+good"){ Search.cancel }   # Stop searching

      $el.define_key :isearch_mode_map, $el.kbd("C-h"), nil

      Xiki.def("search+have+bullet"){ Search.have_label }
      Xiki.def("search+have+case"){ Search.isearch_have_case }
      Xiki.def("search+have+edges"){ Search.just_edges }   # Delete everything but chars at edges of match

      Xiki.def("search+have+file"){ Search.isearch_move_to ":f" }

      Xiki.def("search+have+here"){ Search.insert_at_spot }

      Xiki.def("search+have+javascript"){ Search.isearch_have_outlog_javascript }
      Xiki.def("search+have+line"){ Search.have_line }   # copy line back to search start
      Xiki.def("search+have+move"){ Search.isearch_move_line }   # Move line to where search started

      Xiki.def("search+have+outlog"){ Search.isearch_have_outlog }
      Xiki.def("search+have+push"){ Git.search_just_push }   # When search match

      Xiki.def("search+have+right"){ Search.have_right }
      Xiki.def("search+have+tasks"){ Search.isearch_move_to ":t" }
      Xiki.def("search+have+variable"){ Search.insert_var_at_search_start }

      Xiki.def("search+have+wikipedia"){ Search.isearch_have_wikipedia }   # Grab everything except chars on edges
      # I: leave unmapped - had issues using it (messes up position)
      $el.define_key :isearch_mode_map, $el.kbd("C-j"), nil
      Xiki.def("search+just+after"){ Search.isearch_just_after }
      Xiki.def("search+just+case"){ Search.isearch_just_case }   # make match be camel case
      Xiki.def("search+just+delete"){ Search.like_delete }   # Delete all lines that contain the match
      Xiki.def("search+just+edited"){ Search.just_edits }   # Search in diff of edits to this file

      Xiki.def("search+just+filename"){ Search.isearch_open }   # Open match as filename
      Xiki.def("search+just+thesaurus"){ Search.search_thesaurus }

      Xiki.def("search+just+have"){ Search.just_select }   # select match

      Xiki.def("search+just+kill"){ Search.just_kill }

      Xiki.def("search+just+integer"){ Search.stop; Search.isearch "[0-9][0-9.]*", :regex=>1 }
      Xiki.def("search+just+line"){ $el.toggle_truncate_lines }   # Line wrap without exiting isearch

      Xiki.def("search+just+menu"){ Search.just_menu }
      Xiki.def("search+just+swap"){ Search.search_just_swap }   # Add "##search" line in tree for match
      Xiki.def("search+just+restart"){ Search.isearch_restart :top }

      Xiki.def("search+just+order"){ Search.isearch_just_adjust }
      Xiki.def("search+just+variable"){ Search.isearch_just_surround_with_char '#{', '}' }
      Xiki.def("search+just+parens"){ Search.isearch_just_surround_with_char '(', ')' }
      Xiki.def("search+just+brackets"){ Search.isearch_just_surround_with_char '[', ']' }
      Xiki.def("search+just+quotes"){ Search.isearch_just_surround_with_char '"' }
      Xiki.def("search+just+wrap+apostrophe"){ Search.isearch_just_surround_with_char "'" }

      Xiki.def("search+just+yellow"){ Search.just_orange }


      $el.define_key :isearch_mode_map, $el.kbd("C-l"), nil   # Just do normal layout+ shortcut
      Xiki.def("search+like+after"){ Search.query_replace_with_2 }
      Xiki.def("search+like+command"){ Launcher.search_like_menu }
      Xiki.def("search+like+difflog"){ Search.jump_to_difflog }   # find last string in difflog

      Xiki.def("search+like+files"){ Search.isearch_restart ":f", :as_here=>1 }   # isearch for this string in :f
      Xiki.def("search+like+next"){ Search.isearch_restart :next }
      Xiki.def("search+like+previous"){ Search.isearch_restart :previous }
      Xiki.def("search+like+right"){ Search.isearch_restart :right }   # Search in top-right view

      Xiki.def("search+like+here"){ Search.isearch_just_search }   # Add "##search" line in tree for match

      Xiki.def("search+like+layout"){ $el.recenter 1 }
      Xiki.def("search+like+middle"){ $el.recenter 20
        Ol["Get this to use the actual middle > borrow: tile+middle!"]
      }

      Xiki.def("search+like+outlog"){ Search.isearch_restart "$o" }
      Xiki.def("search+like+quote"){ Search.isearch_google :quote=>true }

      Xiki.def("search+like+expanded"){ Search.like_expanded }
      Xiki.def("search+like+special"){ Search.isearch_just_special }
      Xiki.def("search+like+tasks"){ Search.isearch_restart ":t", :as_here=>1 }
      Xiki.def("search+like+variable"){ Search.just_name }
      Xiki.def("search+like+web"){ Search.isearch_google }   # make match be snake case
      Xiki.def("search+like+xiki"){ View.open ":xiki/#{Search.stop.strip}" }

      $el.define_key(:isearch_mode_map, $el.kbd("C-j C-]")) { Search.just_increment }   # search+just+Plus > alternative for terminal

      $el.define_key(:isearch_mode_map, $el.kbd("C-j C-_")) { Search.just_increment(:decrement=>true) }   # search+just+Minus > alternative for terminal

      $el.el4r_lisp_eval %`
        (progn
          ; Has to be defined in lisp, since passing C-@ fails (it's null, and that's what we use as a delimiter)
          (define-key isearch-mode-map (kbd "C-@") (lambda () (interactive)
            (el4r-ruby-eval "Xiki::Search.isearch_query_replace")
          ))
          ; Lixe isearch-abort, but aborts even if partially matching search in progress
          (defun isearch-abort-really ()
            (interactive)
            (discard-input)
            (setq isearch-success nil)
            (isearch-cancel)
          )
        )
      `

      $el.define_key(:isearch_mode_map, $el.kbd("C-_")) { Search.subtract }   # Remove one char from isearch > alternative for terminal
      $el.define_key(:isearch_mode_map, $el.kbd("C-]")) { $el.isearch_yank_char }     # alternative for terminal
      $el.define_key(:isearch_mode_map, $el.kbd("C-\\"), :isearch_abort_really)


      # Safe mapping of C-m to Search.isearch_m (works when el4r is down)
      $el.el4r_lisp_eval(%`(defun isearch-m () (interactive)
        (message "- - isearch-m")
        (if (eq (process-status el4r-process) 'open) (el4r-ruby-eval "::Xiki::Search.isearch_m") (isearch-exit)))
        `.unindent)

      $el.define_key :isearch_mode_map, $el.kbd("C-m"), :isearch_m   # search+menu (done in a really safe way, so Return in isearch doesn't break when el4r goes down)
    end

    def self.map_control_return

      # Aquamacs-specific: make cua not map C-return key
      $el.define_key(:cua_global_keymap, $el.kbd("<C-return>"), nil) if $el.boundp(:cua_global_keymap)

      Keys.set("<C-return>") { Launcher.go }   # control-return, control-enter
    end

    def self.map_command_return
      return if ! $el.boundp(:osx_key_mode_map)

      $el.define_key(:osx_key_mode_map, $el.kbd("<A-return>")) { Launcher.go }   # Command+Return
    end

    # Not called by default
    def self.map_meta_return
      Keys.set("<M-return>") { Launcher.go }   # Command+Return, Command+Enter
    end

    def self.misc

      Xiki.def("quit+", :noob=>1){ DiffLog.quit }
      $el.define_key :isearch_mode_map, "\C-q", :isearch_quote_char   # This is necessary so "C-s C-q" won't quit
      $el.define_key :minibuffer_local_map, "\C-q", :quoted_insert   # So C-q still quotes control chars in the minibuffer
      Xiki.def("lock+"){ $el.control_lock_enable }
      Xiki.def("yours+"){ Launcher.open("yours/") }

      $el.define_key(:global_map, "\\C-x\\C-m"){ Launcher.open("#{Xiki.dir}\n  - ##^ *def /") }
      $el.define_key(:global_map, "\\C-x\\C-d"){ FileTree.tree :recursive=>1, :bm=>"xiki" }
      $el.define_key(:global_map, "\\C-k"){ Keys.k_key }

      $el.define_key(:global_map, "\\C-x\\C-h"){ $el.help }

      # Disable C-x arrows, so arrows can be used to escape out of all keys
      $el.define_key(:global_map, $el.kbd("C-x <left>"), nil)
      $el.define_key(:global_map, $el.kbd("C-x <right>"), nil)

      Keys.set("C-."){ Keys.repeat }   # Repeat last command typed (like vim "."), except for trivial ones
      Keys.set("C-,"){ Keys.repeat :movement=>1 }   # Repeat last command typed (like vim "."), except for trivial ones

      $el.define_key(:global_map, $el.kbd("C-;")){ Bookmarks.go }
      if $el.boundp(:osx_key_mode_map)
        $el.define_key(:osx_key_mode_map, $el.kbd("C-;")){ Bookmarks.go }
      end

      if $el.locate_library "ruby-mode"
        $el.el_require :ruby_mode
        $el.message ""   # Keep it from showing junk at bottom
        $el.define_key :ruby_mode_map, $el.kbd("C-j"), nil
      end

      $el.define_key :global_map, $el.kbd("C-z"), :undo

      # Unmap keys in modes that interfere
      $el.el4r_lisp_eval("(require 'shell)")
      $el.define_key :shell_mode_map, $el.kbd("C-j"), nil   # shell-mode etc. special C-j shortcuts over-ride xiki

      # In case C-j in scratch buffer
      $el.define_key :lisp_interaction_mode_map, $el.kbd("C-j"), nil

      # C-l in ediff mode
      $el.defun(:ediff_disable_C_l) { $el.define_key(:ediff_mode_map, $el.kbd("C-l"), nil) }
      $el.add_hook :ediff_keymap_setup_hook, :ediff_disable_C_l

      View.sensible_defaults

      Xiki.def("expand+", :noob=>1) { Launcher.go }   # expand+
      Xiki.def("dropdown+", :noob=>1) { Launcher.dropdown }   # expand+

      Xiki.def("backward+"){ Move.backward_key }
      Xiki.def("forward+"){ Move.forward_key }
      Xiki.def("previous+"){ Move.previous }
      Xiki.def("next+"){ Move.next }

      Keys.set("C-'") { Keys.timed_insert }
      Keys.set("C-\\"){ ControlTab.go }

      $el.define_key :global_map, $el.kbd("C-_"), :negative_argument   # For terminals

      # xiki+1, xiki+2, etc (meaning C-x C-2)

      (1..9).each do |n|
        $el.define_key(:global_map, $el.kbd("C-x C-#{n}")){ Launcher.do_last_launch :nth=>n, :here=>1 }
      end

      $el.define_key(:global_map, $el.kbd("C-x C-1")){ Launcher.do_last_launch :nth=>1, :here=>1 }
      $el.define_key(:global_map, $el.kbd("C-x C-2")){ Launcher.do_last_launch :nth=>2, :here=>1 }

    end

    # Defines right-click
    def self.right_click

      # When not gui emacs, invoke what ctrl+D does...

      if ! Environment.gui_emacs

        $el.define_key(:global_map, $el.kbd("<mouse-3>"), $el.el_lambda(:interactive=>"e") {|e|
          $el.mouse_set_point(e)
          Launcher.dropdown
        })

        return
      end

      $el.defun(:xiki_right_click, :interactive=>"e") do |e|
        if ! $el.elvar.mark_active
          $el.mouse_set_point(e)
          View.refresh
        end
        Launcher.right_click
      end

      $el.define_key(:global_map, $el.kbd("<mouse-3>"), :xiki_right_click)

      # In aquamacs, undefine the normal right-click menu...

      if $el.boundp(:osx_key_mode_map)
        $el.define_key(:osx_key_mode_map, $el.kbd("<down-mouse-3>"), nil)
        $el.define_key(:osx_key_mode_map, $el.kbd("<mouse-3>"), nil)

        return
      end

    end

  end
end
