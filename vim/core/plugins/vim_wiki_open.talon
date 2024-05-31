# Is this file is specifically for when the wiki is open
# XXX - detect the actual wiki rather than markdown
# See https://github.com/vimwiki/vimwiki/
tag: user.vim_wiki
and code.language: markdown
-

###
# Internal Vim Wiki Commands
#
# Only accessible when operating inside of a wiki file
###

wiki link:
    user.vim_run_command(":VimwikiFollowLink\n")
wiki back:
    user.vim_run_command(":VimwikiGoBackLink\n")
wiki split link:
    user.vim_run_command(":VimwikiVSplitLink\n")
wiki tab link:
    user.vim_run_command(":VimwikiTabnewLink\n")
wiki next link:
    user.vim_run_command(":VimwikiNextLink\n")

# Convenience for when you aren't directly on the link
go [next] link:
    user.vim_run_command(":VimwikiNextLink\n")
    user.vim_run_command(":VimwikiFollowLink\n")
wiki last link:
    user.vim_run_command(":VimwikiPrevLink\n")
wiki go to:
    user.vim_run_command(":VimwikiGoto ")
wiki rename:
    user.vim_run_command(":VimwikiRenameFile ")
wiki next task:
    user.vim_run_command(":VimwikiNextTask\n")
# XXX - todo HTML stuff
wiki toggle:
    user.vim_run_command(":VimwikiToggleListItem\n")
wiki toggle reject:
    user.vim_run_command(":VimwikiToggleRejectedListItem\n")

# XXX - right, left, etc
# wiki list right:
#     user.vim_run_command(":VimwikiListChangeLevel >>\n")
# wiki list left:
#     user.vim_run_command(":VimwikiListChangeLevel <<\n")

wiki search:
    user.vim_run_command(":VimwikiSearch ")
wiki find links:
    user.vim_run_command(":VimwikiBacklinks\n")

wiki table:
    user.vim_run_command(":VimwikiTable\n")
wiki <number_small> by <number_small> table:
    user.vim_run_command(":VimwikiTable {number_small_1} {number_small_2}\n")
wiki <number_small> table:
    user.vim_run_command(":VimwikiTable {number_small}\n")
wiki move call left:
    user.vim_run_command(":VimwikiTableMoveColumnLeft\n")
wiki move call right:
    user.vim_run_command(":VimwikiTableMoveColumnRight\n")

# TODO - change command to update wiki?
wiki generate links:
    user.vim_run_command(":VimwikiGenerateLinks")
# TODO - change command to update diary?
wiki generate diary links:
    user.vim_run_command(":VimwikiDiaryGenerateLinks\n")
# :VimwikiDiaryNextDay - redundant? See global diary next
# :VimwikiDiaryPrevDay - redundant? See global diary last
wiki talk:
    user.vim_run_command(":VimwikiTOC\n")
wiki check links:
    user.vim_run_command(":VimwikiCheckLinks\n")
wiki rebuild tags:
    user.vim_run_command(":VimwikiRebuildTags\n")
wiki search tags:
    user.vim_run_command(":VimwikiSearchTags\n")
wiki generate tag links:
    user.vim_run_command(":VimwikiGenerateTagLinks\n")

###
# VimWiki Syntax
#
# TODO - Start from 5. Wiki syntax in :help vimwiki
###
