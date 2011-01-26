;;; latex-symbols.el --- display tables of (La)TeX symbols in XEmacs.
;; Copyright (c) 1999, 2000, 2001
;; John Palmieri

;; Author:     John Palmieri <palmieri@math.washington.edu>
;; Maintainer: John Palmieri <palmieri@math.washington.edu>
;;             URL: http://www.math.washington.edu/~palmieri/Emacs/latex-symbols.html
;; Keywords: TeX symbols, xpm
;; Version:  0.04 of Mon Aug 13 16:29:13 PDT 2001

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This file is not part of GNU Emacs.

;; This package is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This package is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Description:
;;
;; This file contains code to display tables of (La)TeX symbols from
;; xpm files (or other formats) of pictures of those symbols.
;;
;; To use: first, make sure your version of XEmacs was compiled with
;; xpm support (evaluate "(featurep 'xpm)" and see if it says t or
;; nil).  Note that you can use other formats for the picture files,
;; but xpm files will handle different background colors a bit more
;; gracefully than other types.
;;
;; Second, unpack the xpm picture archive.  Make sure the variable
;; latex-symbol-directory is set to the parent directory--e.g., if you
;; have a directory 
;;                "/home/smith/latex-sym/xpm/" 
;; filled with xpm files, then set latex-symbol-directory to
;; "/home/smith/latex-sym/".  (If you want to use another format, say
;; gif, you should convert the xpm files to gif files and put them in
;; a subdirectory "gif" instead of "xpm".  Note that jpeg files should 
;; end in .jpg and be put in a directory "jpg", rather than "jpeg".)
;;
;; Third, load this file and run any of these commands:
;;
;;         M-x latex-symbol-greek
;;         M-x latex-symbol-operators
;;         M-x latex-symbol-relations
;;         M-x latex-symbol-arrows
;;         M-x latex-symbol-miscellany
;;         M-x latex-symbol-all
;;
;; If you create your own xpm files for other symbols, then put the
;; files in the xpm directory, define the variable ls-other to be a
;; list of the names of those symbols, and run this to get a table of
;; your symbols:
;;
;;         M-x latex-symbol-other
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Version history:
;;
;; 0.04 (2001-08-13).  Fixed incompatibility with new XEmacs: use
;;                     extents instead of annotations.
;; 0.03 (1999-06-29).  Changed my e-mail address, URL.
;; 0.02 (1999-05-11).  Added lists of symbols organized by package.
;;                     Fixed a few typos, too.
;; 0.1  (1999-04-28).  Initial release
;;

(defgroup latex-symbols nil
  "Display tables of (La)TeX symbols."
  :tag "LaTeX symbols"
  :link '(url-link :tag "Home Page" "http://www.math.washington.edu/~palmieri/Emacs/latex-symbols.html")
  :group 'tex)

(defcustom latex-symbol-picture-type (if (featurep 'xpm) 'xpm nil)
  "Format of picture file used."
  :type '(choice (const :tag "xpm" xpm)
		 (const :tag "gif" gif)	
		 (const :tag "png" png)
		 (const :tag "tiff" tiff)
		 (const :tag "xface" xface)
		 (const :tag "jpeg" jpeg)
		 (const :tag "xbm" xbm)
		 (const :tag "none" nil))
  :group 'latex-symbols)

(defun ls-picture-type-name ()
  "Return symbol name associated to latex-symbol-picture-type, except
picture type 'jpeg will give \"jpg\" instead of \"jpeg\"."
  (if (eq latex-symbol-picture-type 'jpg)
      "jpeg"
    (symbol-name latex-symbol-picture-type)))
  
(defvar latex-symbol-picture-type latex-symbol-picture-type
  "Format of picture file used.  Don't set by hand--this gets set
automatically when customizing latex-symbol-picture-type.")

(defcustom latex-symbol-directory
  (if (locate-library "latex-symbols")
      (substring (locate-library "latex-symbols")
		 0
		 (string-match "latex-symbols.el"
				(locate-library "latex-symbols")))
    ".")
  "Directory containing (La)TeX symbols.
This directory should have a subdirectory called \"xpm\" (or \"gif\" or
\"jpg\" or whatever picture format you're using)."
  :type '(file :must-match t)
  :group 'latex-symbols)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; symbols organized by type:

(defconst ls-greek
  '("alpha" "beta" "chi" "Delta" "delta" "epsilon" "eta" "Gamma"
    "gamma" "iota" "kappa" "Lambda" "lambda" "mu" "nu" "Omega" "omega"
    "Phi" "phi" "Pi" "pi" "Psi" "psi" "rho" "Sigma" "sigma" "tau" "Theta"
    "theta" "Upsilon" "upsilon" "varepsilon" "varkappa" "varphi" "varpi"
    "varrho" "varsigma" "vartheta" "Xi" "xi" "zeta")
  "List of names of Greek letters contained in LaTeX symbol distribution.")

(defconst ls-rels
  '("approx" "approxeq" "asymp" "backsim" "backsimeq" "bot" "bowtie"
    "Bumpeq" "bumpeq" "circeq" "cong" "curlyeqprec" "curlyeqsucc" "dashv"
    "Doteq" "doteq" "doteqdot" "eqcirc" "eqsim" "eqslantgtr" "eqslantless"
    "equiv" "fallingdotseq" "frown" "geq" "geqq" "geqslant" "gg" "ggg"
    "gggtr" "gnapprox" "gneq" "gneqq" "gnsim" "gtrapprox" "gtrdot"
    "gtreqless" "gtreqqless" "gtrless" "gtrsim" "gvertneqq" "in" "inplus"
    "Join" "leq" "leqq" "leqslant" "lessapprox" "lessdot" "lesseqgtr"
    "lesseqqgtr" "lessgtr" "lesssim" "lhd" "ll" "lll" "llless" "lnapprox"
    "lneq" "lneqq" "lnsim" "lvertneqq" "models" "napprox" "ncong" "neq"
    "ngeq" "ngeqq" "ngeqslant" "ngtr" "ni" "niplus" "nleq" "nleqq"
    "nleqslant" "nless" "nmid" "notin" "nparallel" "nprec" "npreceq"
    "nshortmid" "nshortparallel" "nsim" "nsubseteq" "nsubseteqq" "nsucc"
    "nsucceq" "nsupseteq" "nsupseteqq" "ntriangleleft" "ntrianglelefteq"
    "ntrianglelefteqslant" "ntriangleright" "ntrianglerighteq"
    "ntrianglerighteqslant" "nvDash" "nvdash" "ogreaterthan" "olessthan"
    "parallel" "perp" "prec" "precapprox" "preccurlyeq" "preceq"
    "precnapprox" "precneqq" "precnsim" "precsim" "propto" "rhd"
    "risingdotseq" "sim" "simeq" "smallfrown" "smallsmile" "smile"
    "sqsubset" "sqsubseteq" "sqsupset" "sqsupseteq" "Subset" "subset"
    "subseteq" "subseteqq" "subsetneq" "subsetneqq" "subsetplus"
    "subsetpluseq" "succ" "succapprox" "succcurlyeq" "succeq"
    "succnapprox" "succneqq" "succnsim" "succsim" "Supset" "supset"
    "supseteq" "supseteqq" "supsetneq" "supsetneqq" "supsetplus"
    "supsetpluseq" "thickapprox" "thicksim" "triangleleft"
    "trianglelefteq" "trianglelefteqslant" "triangleq" "triangleright"
    "trianglerighteq" "trianglerighteqslant" "unlhd" "unrhd"
    "varogreaterthan" "varolessthan" "varpropto" "varsubsetneq"
    "varsubsetneqq" "varsupsetneq" "varsupsetneqq" "vartriangleleft"
    "vartriangleright" "Vdash" "vDash" "vdash" "Vvdash")
  "List of names of binary relations contained in LaTeX symbol distribution.")

(defconst ls-ops
  '("amalg" "barwedge" "bigcap" "bigcup" "bigcurlyvee" "bigcurlywedge"
    "bignplus" "bigodot" "bigoplus" "bigotimes" "bigsqcap" "bigsqcup"
    "biguplus" "bigvee" "bigwedge" "boxast" "boxbar" "boxbox" "boxbslash"
    "boxcircle" "boxdot" "boxempty" "boxminus" "boxplus" "boxslash"
    "boxtimes" "Cap" "cap" "circledast" "circledcirc" "circleddash"
    "coprod" "Cup" "cup" "curlyvee" "curlyveedownarrow" "curlyveeuparrow"
    "curlywedge" "curlywedgedownarrow" "curlywedgeuparrow" "div"
    "divideontimes" "dotplus" "doublebarwedge" "doublecap" "doublecup"
    "nplus" "obar" "obslash" "odot" "ominus" "oplus" "oslash" "otimes"
    "ovee" "owedge" "sqcap" "sqcup" "times" "uplus" "varcurlyvee"
    "varcurlywedge" "varoast" "varobar" "varobslash" "varocircle"
    "varodot" "varominus" "varoplus" "varoslash" "varotimes" "varovee"
    "varowedge" "vartimes" "vee" "veebar" "wedge" "wr")
  "List of names of binary operators contained in LaTeX symbol distribution.")

(defconst ls-arrows
  '("curvearrowleft" "curvearrowright" "dasharrow" "dashleftarrow"
    "dashrightarrow" "Downarrow" "downarrow" "downdownarrows"
    "downharpoonleft" "downharpoonright" "hookrightarrow" "iff"
    "leadsto" "Leftarrow" "leftarrow" 
    "leftarrowtail" "leftarrowtriangle" "leftharpoondown" "leftharpoonup"
    "leftleftarrows" "Leftrightarrow" "leftrightarrow" "leftrightarroweq"
    "leftrightarrows" "leftrightarrowtriangle" "leftrightharpoons"
    "leftrightsquigarrow" "Lleftarrow" "Longleftarrow" "longleftarrow"
    "Longleftrightarrow" "longleftrightarrow" "Longmapsfrom"
    "longmapsfrom" "Longmapsto" "longmapsto" "Longrightarrow"
    "longrightarrow" "looparrowleft" "looparrowright" "Mapsfrom"
    "mapsfrom" "Mapsto" "mapsto" "multimap" "nearrow" "nLeftarrow"
    "nleftarrow" "nLeftrightarrow" "nleftrightarrow" "nnearrow" "nnwarrow"
    "nRightarrow" "nrightarrow" "nwarrow" "Rightarrow" "rightarrow"
    "rightarrowtail" "rightarrowtriangle" "rightharpoondown"
    "rightharpoonup" "rightleftarrows" "rightleftharpoons"
    "rightrightarrows" "rightsquigarrow" "Rrightarrow" "searrow"
    "shortdownarrow" "shortleftarrow" "shortrightarrow" "shortuparrow"
    "ssearrow" "sswarrow" "swarrow" "twoheadleftarrow" "twoheadrightarrow"
    "Uparrow" "uparrow" "Updownarrow" "updownarrow" "upharpoonleft"
    "upharpoonright" "upuparrows")
  "List of names of arrows contained in LaTeX symbol distribution.")
  
(defconst ls-misc
  '("aleph" "angle" "ast" "backepsilon" "backprime" "backslash" "baro"
    "Bbbk" "bbslash" "because" "beth" "between" "bigbox" "bigcirc"
    "biginterleave" "bigparallel" "bigstar" "bigtriangledown"
    "bigtriangleup" "binampersand" "bindnasrepma" "blacklozenge"
    "blacksquare" "blacktriangle" "blacktriangledown" "blacktriangleleft"
    "blacktriangleright" "Box" "bullet" "cdot" "cdotp" "cdots" "centerdot"
    "checkmark" "circ" "circlearrowleft" "circlearrowright" "circledR"
    "circledS" "clubsuit" "colon" "complement" "copyright" "dag" "dagger"
    "daleth" "ddag" "ddagger" "ddots" "diagdown" "diagup" "diamond"
    "diamondsuit" "digamma" "dots" "dotsc" "dotsi" "dotsm" "ell"
    "emptyset" "eth" "exists" "fatbslash" "fatsemi" "fatslash" "Finv"
    "flat" "forall" "Game" "gimel" "hbar" "heartsuit" "hslash" "idotsint"
    "iiiint" "iiint" "iint" "Im" "imath" "infty" "int" "intercal"
    "interleave" "intop" "jmath" "langle" "Lbag" "lbag" "lbrace" "lceil"
    "ldotp" "ldots" "leftslice" "leftthreetimes" "lfloor" "lhook"
    "lightning" "llbracket" "llceil" "llcorner" "llfloor" "llparenthesis"
    "lmoustache" "lozenge" "lrcorner" "Lsh" "ltimes" "lVert" "lvert"
    "maltese" "measuredangle" "merge" "mho" "mid" "minuso" "moo" "mp"
    "nabla" "natural" "neg" "nexists" "not" "nVDash" "nVdash" "oblong"
    "oint" "ointop" "P" "partial" "pitchfork" "pm" "prime" "prod" "qed"
    "qedsymbol" "rangle" "Rbag" "rbag" "rbrace" "rceil" "Re" "Relbar"
    "relbar" "restriction" "rfloor" "rhook" "rightslice" "rightthreetimes"
    "rmoustache" "rrbracket" "rrceil" "rrfloor" "rrparenthesis" "Rsh"
    "rtimes" "rVert" "rvert" "S" "setminus" "sharp" "shortmid"
    "shortparallel" "smallint" "smallsetminus" "spadesuit"
    "sphericalangle" "sqrt" "square" "sslash" "star" "sum" "surd"
    "talloblong" "TeX" "therefore" "top" "triangle" "triangledown"
    "ulcorner" "urcorner" "varbigcirc" "varcopyright" "varnothing"
    "vartriangle" "vdots" "Vert" "vert" "wp" "Ydown" "yen" "Yleft"
    "Yright" "Yup")
  "List of names of misc. symbols contained in LaTeX symbol distribution.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; symbols organized by package:

(defconst ls-plain
  '("Delta" "Downarrow" "Gamma" "Im" "Lambda" "Leftarrow"
    "Leftrightarrow" "Longleftarrow" "Longleftrightarrow"
    "Longrightarrow" "Omega" "P" "Phi" "Pi" "Psi" "Re" "Relbar"
    "Rightarrow" "S" "Sigma" "TeX" "Theta" "Uparrow" "Updownarrow"
    "Upsilon" "Vert" "Xi" "aleph" "alpha" "amalg" "angle" "approx"
    "ast" "asymp" "backslash" "beta" "bigcap" "bigcirc" "bigcup"
    "bigodot" "bigoplus" "bigotimes" "bigsqcup" "bigtriangledown"
    "bigtriangleup" "biguplus" "bigvee" "bigwedge" "bot" "bowtie"
    "bullet" "cap" "cdot" "cdotp" "cdots" "chi" "circ" "clubsuit"
    "colon" "cong" "coprod" "copyright" "cup" "dag" "dagger"
    "dashv" "ddag" "ddagger" "ddots" "delta" "diamond"
    "diamondsuit" "div" "doteq" "dots" "downarrow" "ell" "emptyset"
    "epsilon" "equiv" "eta" "exists" "flat" "forall" "frown"
    "gamma" "geq" "gg" "hbar" "heartsuit" "hookrightarrow" "iff"
    "imath" "in" "infty" "int" "intop" "iota" "jmath" "kappa"
    "lambda" "langle" "lbrace" "lceil" "ldotp" "ldots" "leftarrow"
    "leftharpoondown" "leftharpoonup" "leftrightarrow" "leq" "lfloor"
    "lhook" "ll" "lmoustache" "longleftarrow" "longleftrightarrow"
    "longmapsto" "longrightarrow"
    "mapsto" "mid" "models" "mp" "mu" "nabla"
    "natural" "nearrow" "neg" "neq" "ni" "not" "notin" "nu"
    "nwarrow" "odot" "oint" "ointop" "omega" "ominus" "oplus"
    "oslash" "otimes" "parallel" "partial" "perp" "phi" "pi" "pm"
    "prec" "preceq" "prime" "prod" "propto" "psi" "rangle"
    "rbrace" "rceil" "relbar" "rfloor" "rho" "rhook" "rightarrow"
    "rightharpoondown" "rightharpoonup" "rightleftharpoons"
    "rmoustache" "searrow" "setminus" "sharp" "sigma" "sim" "simeq"
    "smallint" "smile" "spadesuit" "sqcap" "sqcup" "sqrt{}"
    "sqsubseteq" "sqsupseteq" "star" "subset" "subseteq" "succ"
    "succeq" "sum" "supset" "supseteq" "surd" "swarrow" "tau"
    "theta" "times" "top" "triangle" "triangleleft" "triangleright"
    "uparrow" "updownarrow" "uplus" "upsilon" "varepsilon" "varphi"
    "varpi" "varrho" "varsigma" "vartheta" "vdash" "vdots" "vee"
    "vert" "wedge" "wp" "wr" "xi" "zeta")
  "List of symbols defined in plain TeX or LaTeX or something.")

(defconst ls-latexsym
  '("Join" "lhd" "mho" "rhd" "sqsubset" "sqsupset" "unlhd" "unrhd")
  "List of symbols defined in latexsym.sty.")

(defconst ls-amsfonts
  '("checkmark" "circledR" "dasharrow" "dashleftarrow"
    "dashrightarrow" "lhd" "llcorner" "lrcorner" "maltese" "mho" "rhd"
    "sqsubset" "sqsupset" "ulcorner" "unlhd" "unrhd" "urcorner" "yen")
  "List of symbols defined in amsfonts.sty.")

(defconst ls-amsmath
  '("dotsc" "dotsi" "dotsm" "idotsint" "iiiint" "iiint" "iint" "lVert"
    "lvert" "rVert" "rvert")
  "List of symbols defined in amsmath.sty.")

(defconst ls-amssymb
  '("Bbbk" "Bumpeq" "Cap" "Cup" "Doteq" "Finv" "Game"
    "Lleftarrow" "Lsh" "Rrightarrow" "Rsh" "Subset" "Supset"
    "Vdash" "Vvdash" "approxeq" "backepsilon" "backprime" "backsim"
    "backsimeq" "barwedge" "because" "beth" "between" "bigstar"
    "blacklozenge" "blacksquare" "blacktriangle" "blacktriangledown"
    "blacktriangleleft" "blacktriangleright" "boxdot" "boxminus"
    "boxplus" "boxtimes" "bumpeq" "centerdot" "circeq"
    "circlearrowleft" "circlearrowright" "circledS" "circledast"
    "circledcirc" "circleddash" "complement" "curlyeqprec"
    "curlyeqsucc" "curlyvee" "curlywedge" "curvearrowleft"
    "curvearrowright" "daleth" "diagdown" "diagup" "digamma"
    "divideontimes" "doteqdot" "dotplus" "doublebarwedge" "doublecap"
    "doublecup" "downdownarrows" "downharpoonleft" "downharpoonright"
    "eqcirc" "eqsim" "eqslantgtr" "eqslantless" "eth"
    "fallingdotseq" "geqq" "geqslant" "ggg" "gggtr" "gimel"
    "gnapprox" "gneq" "gneqq" "gnsim" "gtrapprox" "gtrdot"
    "gtreqless" "gtreqqless" "gtrless" "gtrsim" "gvertneqq" "hslash"
    "intercal" "leftarrowtail" "leftleftarrows" "leftrightarrows"
    "leftrightharpoons" "leftrightsquigarrow" "leftthreetimes" "leqq"
    "leqslant" "lessapprox" "lessdot" "lesseqgtr" "lesseqqgtr"
    "lessgtr" "lesssim" "lll" "llless" "lnapprox" "lneq" "lneqq"
    "lnsim" "looparrowleft" "looparrowright" "lozenge" "ltimes"
    "lvertneqq" "measuredangle" "multimap" "nLeftarrow"
    "nLeftrightarrow" "nRightarrow" "nVDash" "nVdash" "ncong"
    "nexists" "ngeq" "ngeqq" "ngeqslant" "ngtr" "nleftarrow"
    "nleftrightarrow" "nleq" "nleqq" "nleqslant" "nless" "nmid"
    "nparallel" "nprec" "npreceq" "nrightarrow" "nshortmid"
    "nshortparallel" "nsim" "nsubseteq" "nsubseteqq" "nsucc"
    "nsucceq"  "nsupseteq" "nsupseteqq"
    "ntriangleleft" "ntrianglelefteq" "ntriangleright"
    "ntrianglerighteq" "nvDash" "nvdash" "pitchfork" "precapprox"
    "preccurlyeq" "precnapprox" "precneqq" "precnsim" "precsim"
    "restriction" "rightarrowtail" "rightleftarrows"
    "rightrightarrows" "rightsquigarrow" "rightthreetimes"
    "risingdotseq" "rtimes" "shortmid" "shortparallel" "smallfrown"
    "smallsetminus" "smallsmile" "sphericalangle" "square"
    "subseteqq" "subsetneq" "subsetneqq" "succapprox" "succcurlyeq"
    "succnapprox" "succneqq" "succnsim" "succsim" "supseteqq"
    "supsetneq" "supsetneqq" "therefore" "thickapprox" "thicksim"
    "triangledown" "trianglelefteq" "triangleq" "trianglerighteq"
    "twoheadleftarrow" "twoheadrightarrow" "upharpoonleft"
    "upharpoonright" "upuparrows" "vDash" "varkappa" "varnothing"
    "varpropto" "varsubsetneq" "varsubsetneqq" "varsupsetneq"
    "varsupsetneqq" "vartriangle" "vartriangleleft" "vartriangleright"
    "veebar")
  "List of symbols defined in amssymb.sty.")

(defconst ls-amsthm
  '("qed" "qedsymbol")
  "List of symbols defined in amsthm.sty.")

(defconst ls-stmaryrd
  '("Lbag" "Longmapsfrom" "Longmapsto" "Mapsfrom" "Mapsto"
    "Rbag" "Ydown" "Yleft" "Yright" "Yup" "baro" "bbslash"
    "bigbox" "bigcurlyvee" "bigcurlywedge" "biginterleave" "bignplus"
    "bigparallel" "bigsqcap" "binampersand" "bindnasrepma" "boxast"
    "boxbar" "boxbox" "boxbslash" "boxcircle" "boxempty" "boxslash"
    "curlyveedownarrow" "curlyveeuparrow" "curlywedgedownarrow"
    "curlywedgeuparrow" "fatbslash" "fatsemi" "fatslash" "inplus"
    "interleave" "lbag" "leftarrowtriangle" "leftrightarroweq"
    "leftrightarrowtriangle" "leftslice" "lightning" "llbracket"
    "llceil" "llfloor" "llparenthesis" "longmapsfrom" "mapsfrom"
    "merge" "minuso" "moo" "niplus" "nnearrow" "nnwarrow" "nplus"
    "ntrianglelefteqslant" "ntrianglerighteqslant" "obar" "oblong"
    "obslash" "ogreaterthan" "olessthan" "ovee" "owedge" "rbag"
    "rightarrowtriangle" "rightslice" "rrbracket" "rrceil" "rrfloor"
    "rrparenthesis" "shortdownarrow" "shortleftarrow"
    "shortrightarrow" "shortuparrow" "ssearrow" "sslash" "sswarrow"
    "subsetplus" "subsetpluseq" "supsetplus" "supsetpluseq"
    "talloblong" "trianglelefteqslant" "trianglerighteqslant"
    "varbigcirc" "varcopyright" "varcurlyvee" "varcurlywedge"
    "varoast" "varobar" "varobslash" "varocircle" "varodot"
    "varogreaterthan" "varolessthan" "varominus" "varoplus"
    "varoslash" "varotimes" "varovee" "varowedge" "vartimes")
  "List of symbols defined in stmaryrd.sty.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar ls-other '()
  "List of names of other symbols.  Intended use: if you wants to add
your own symbols, then put your xpm files into the \"xpm\" subdirectory of
`latex-symbol-directory' (or your gif files into \"gif\" or ...) and
define this variable to be a list of their names.  Run
`M-x latex-symbol-other' to get a table of them.") 

(defconst ls-all
  (sort
   (append ls-greek ls-ops ls-rels
	   ls-arrows ls-misc ls-other)
   (function (lambda (s1 s2)
	       (string< (downcase s1) (downcase s2))))))

(defun ls-display-picture (picture-file pad bufname)
  "Display image in PICTURE-FILE.  Add PAD spaces, some before, some
after.  Display in buffer BUF.  Return the width of the image, so one
can fix bad spacing."
  (let ((half (/ pad 2))
	(glyph (make-glyph (vector latex-symbol-picture-type
				   :file picture-file)))
	extent)
    (princ (make-string half ?\ ))
    (save-excursion
      (set-buffer (get-buffer bufname))
      (setq extent (make-extent (point) (point))))
    (set-extent-begin-glyph extent glyph)
    (princ (make-string (- pad half) ?\ ))
    (glyph-width glyph)))

(defun latex-symbol-greek ()
  "Pop up window showing a table of Greek letters."
  (interactive)
  (ls-display-symbols 'greek))

(defun latex-symbol-operators ()
  "Pop up window showing a table of binary operators (like times, wedge, ...)."
  (interactive)
  (ls-display-symbols 'operators))

(defun latex-symbol-relations ()
  "Pop up window showing a table of binary relations (like cong, sim, ...)."
  (interactive)
  (ls-display-symbols 'relations))

(defun latex-symbol-arrows ()
  "Pop up window showing a table of arrows."
  (interactive)
  (ls-display-symbols 'arrows))

(defun latex-symbol-miscellany ()
  "Pop up window showing a table of miscellaneous symbols."
  (interactive)
  (ls-display-symbols 'miscellany))

(defun latex-symbol-other ()
  "Pop up window showing a table of other (user-defined) symbols."
  (interactive)
  (ls-display-symbols 'other))

(defun latex-symbol-all ()
  "Pop up window showing a table of many (La)TeX symbols."
  (interactive)
  (ls-display-symbols 'all))

(defun latex-symbol-plain ()
  "Pop up window showing a table of symbols defined in plain (La)TeX."
  (interactive)
  (ls-display-symbols 'plain))

(defun latex-symbol-latexsym ()
  "Pop up window showing a table of symbols defined in latexsym.sty."
  (interactive)
  (ls-display-symbols 'latexsym))

(defun latex-symbol-amsfonts ()
  "Pop up window showing a table of symbols defined in amsfonts.sty."
  (interactive)
  (ls-display-symbols 'amsfonts))

(defun latex-symbol-amsmath ()
  "Pop up window showing a table of symbols defined in amsmath.sty."
  (interactive)
  (ls-display-symbols 'amsmath))

(defun latex-symbol-amssymb ()
  "Pop up window showing a table of symbols defined in amssymb.sty."
  (interactive)
  (ls-display-symbols 'amssymb))

(defun latex-symbol-amsthm ()
  "Pop up window showing a table of symbols defined in amsthm.sty."
  (interactive)
  (ls-display-symbols 'amsthm))

(defun latex-symbol-stmaryrd ()
  "Pop up window showing a table of symbols defined in stmaryrd.sty."
  (interactive)
  (ls-display-symbols 'stmaryrd))

(defun ls-display-symbols (arg)
  "Pop up window showing all symbols of type ARG.
ARG may be one of
   'greek         to show greek letters
   'operators     to show binary operators
   'relations     to show binary relations
   'arrows        to show arrows
   'miscellany    to show everything else
   'other         to show other symbols
   'all           to show everything

   'plain         to show symbols defined in plain TeX/LaTeX
   'latexsym      to show symbols defined in latexsym.sty
   'amsfonts      to show symbols defined in amsfonts.sty
   'amsmath       to show symbols defined in amsmath.sty
   'amssymb       to show symbols defined in amssymb.sty
   'amsthm        to show symbols defined in amsthm.sty
   'stmaryrd      to show symbols defined in stmaryrd.sty"
  (let ((symbol-list
	 (cdr
	  (assoc
	   arg
	   (list (cons 'greek ls-greek)
		 (cons 'operators ls-ops)
		 (cons 'relations ls-rels)
		 (cons 'arrows ls-arrows)
		 (cons 'miscellany ls-misc)
		 (cons 'other ls-other)
		 (cons 'all ls-all)
		 (cons 'plain ls-plain)
		 (cons 'latexsym ls-latexsym)
		 (cons 'amsfonts ls-amsfonts)
		 (cons 'amsmath ls-amsmath)
		 (cons 'amssymb ls-amssymb)
		 (cons 'amsthm ls-amsthm)
		 (cons 'stmaryrd ls-stmaryrd)))))
	(bufname (concat " *(La)TeX symbols: " (symbol-name arg)))
	col1 col2 col3
	third
	max-length
	(default-width (face-width 'default))
	(spaces 5)
	(old-window (selected-window))
	glyph
	extent
	(row 1) (column 1))
    (if symbol-list
	(progn
	  (with-output-to-temp-buffer bufname
	    (setq third (/ (+ 2 (length symbol-list)) 3)
		  max-length (apply 'max (mapcar 'length symbol-list)))
	    (while symbol-list
	      (cond
	       ((= column 1)
		(setq col1 (cons (car symbol-list) col1)))
	       ((= column 2)
		(setq col2 (cons (car symbol-list) col2)))
	       ((= column 3)
		(setq col3 (cons (car symbol-list) col3))))
	      (setq symbol-list (cdr symbol-list))
	      (if (eq row third)
		  (setq row 1
			column (1+ column))
		(setq row (1+ row))))
	    (setq col1 (nreverse col1))
	    (setq col2 (nreverse col2))
	    (setq col3 (nreverse col3))
	    (while (or col1 col2 col3)
	      (setq glyph
		    (make-glyph
		     (vector latex-symbol-picture-type
			     :file
			     (expand-file-name
			      (concat "STRUT."
				      (ls-picture-type-name))
			      (expand-file-name
			       (ls-picture-type-name)
			       latex-symbol-directory)))))
	      (set-glyph-property glyph 'baseline 50)
	      (save-excursion
		(set-buffer (get-buffer bufname))
		(setq extent (make-extent (point) (point))))
	      (set-extent-begin-glyph extent glyph)
	      (princ "     ")
	      (if col1
		  (progn
		    (setq spaces
			  (- 5
			     (/ (ls-draw-sym (car col1) bufname)
				default-width)))
		    (princ (make-string
			    (+ spaces
			       (- max-length (length (car col1))))
			    ?\ ))
		    (setq col1 (cdr col1))))
	      (if col2
		  (progn
		    (setq spaces
			  (- 5
			     (/ (ls-draw-sym (car col2) bufname)
				default-width)))
		    (princ (make-string
			    (+ spaces
			       (- max-length (length (car col2))))
			    ?\ ))
		    (setq col2 (cdr col2))))
	      (if col3
		  (progn
		    (ls-draw-sym (car col3) bufname)
		    (setq col3 (cdr col3))))
	      (terpri)))
	  (save-excursion
	    (select-window (get-buffer-window (get-buffer bufname)))
	    (setq truncate-lines t)
	    (select-window old-window)))
      (message "Unknown symbol type: %s" (symbol-name arg)))))

(defun ls-draw-sym (sym buf)
  "Insert SYM, a string, followed by corresponding picture, into BUF."
  (prog1
      (ls-display-picture
       (expand-file-name
	(concat sym "." (ls-picture-type-name))
	(expand-file-name (ls-picture-type-name)
			  latex-symbol-directory))
       0
       buf)
    (princ " ")
    (princ sym)))

(defun ls-lookup-symbol (str)
  "Given string STR (such as \"alpha\" or \"longrightarrow\"), return
list of packages in which that symbol is defined."
  (interactive "sLookup symbol: ")
  (let ((symbol (if (string= "\\" (substring str 0 1))
		    (substring str 1)
		  str))
	(packages (list (cons "plain" ls-plain)
			(cons "latexsym" ls-latexsym)
			(cons "amsfonts" ls-amsfonts)
			(cons "amsmath" ls-amsmath)
			(cons "amssymb" ls-amssymb)
			(cons "amsthm" ls-amsthm)
			(cons "stmaryrd" ls-stmaryrd)))
	answer)
    (while packages
      (if (member symbol (cdar packages))
	  (setq answer (cons (caar packages) answer)))
      (setq packages (cdr packages)))
    (if answer 
	(message "%s is defined in %s."
		 str
		 (mapconcat 'format answer ", "))
      (message "Unknown symbol: %s" str)) 
    answer))

(provide 'latex-symbols)

;;; latex-symbols.el ends here
