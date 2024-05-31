# You must install: https://github.com/kshenoy/vim-signature
tag: user.vim_signature
-

signature toggle:
    user.vim_run_normal_exterm(":SignatureToggle\n")
signature refresh:
    user.vim_run_normal_exterm(":SignatureRefresh\n")
mark here:
    user.vim_run_normal_exterm("m,")
mark toggle:
    user.vim_run_normal_exterm("m.")
mark remove:
    user.vim_run_normal_exterm("m-")
mark next:
    user.vim_run_normal_exterm("]`")
mark last:
    user.vim_run_normal_exterm("[`")
