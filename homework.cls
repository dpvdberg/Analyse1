%
% Homework template for Eindhoven University of Technology Mathematics.
% @author Sten Wessel
% @license MIT
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2016/09/09 Eindhoven University of Technology Mathematics homework template by Sten Wessel]

% CHANGELOG
% 2019/09/09
%  - Added license and generalized template.
%
% 2016/04/26
%  - Added comments.
%  - Renamed `\img' to `\map' since that is the correct english word.
%  - Added the `inlinetoprove' environment.
%  - Added the `\intr' operator for interior (of sets). (`\int' is already in use for integrals.)
%  - Updated the `\emptyset' symbol (much nicer now). For the old symbol the command `\oldemptyset' is available.
%
% 2016/04/30
%  - Added \dist as math operator (for distance).

\LoadClass[a4paper]{exam}

\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=hw,prefix=hw@}
\DeclareStringOption{week}
\ProcessKeyvalOptions*

\RequirePackage[fleqn]{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{stmaryrd}
\RequirePackage{amsfonts}
\RequirePackage{appendix}
\RequirePackage{etoolbox}
\RequirePackage{enumerate}
\RequirePackage{gauss}
\RequirePackage{scalerel}
\RequirePackage{stackengine}
\RequirePackage{xifthen}
\RequirePackage{gauss}
\RequirePackage{lmodern}
\RequirePackage{etoolbox}
\RequirePackage{gensymb}
\RequirePackage{color}
\RequirePackage{colortbl}
\RequirePackage{multirow}
\RequirePackage{hhline}
\RequirePackage{needspace}
\RequirePackage{enumitem}
\RequirePackage{mathtools}
\RequirePackage{mathrsfs}
\RequirePackage[deletedmarkup=xout]{changes}

\footer{}{}{}
\title{\textbf{Analysis 1 elaborations}\\College \hw@week}
\author{Sophie van den Eerenbeemt\\Dennis van den Berg}
\date{\today}

\setlength{\oddsidemargin}{0in}
\setlength{\evensidemargin}{0in}
\setlength{\topmargin}{0in}
\setlength{\headsep}{-.25in}
\setlength{\textwidth}{6.5in}
\setlength{\textheight}{8.5in}

\setlength{\parindent}{1cm}

% Te bewijzen environment
\theoremstyle{definition}
\newtheorem*{toprove}{To prove}

% Interior
\DeclareMathOperator{\intr}{int}
\DeclareMathOperator{\dist}{dist}

% Volume
\DeclareMathOperator{\Vol}{Vol}

% Q.E.D.
\renewcommand{\qedsymbol}{\footnotesize$\boxempty$ \textsc{q.\,e.\,d.}}

% Dfrac shall not be used (except for extreme cases, contact me or work around it yourself)
\renewcommand{\dfrac}[2]{\frac{#1}{#2}}

% Better phi
\let\temp\phi
\let\phi\varphi
\let\varphi\temp

% Better epsilon
\let\temp\epsilon
\let\epsilon\varepsilon
\let\varepsilon\temp

% Better empty set
\let\oldemptyset\emptyset
\let\emptyset\varnothing

% // Shall not be used when not in a split environment or table (use a blank line)
\let\oldbreak\\
\renewcommand*{\\}{\ifmmode \oldbreak \else $\boxed{\hat{\delta}}$ \fi}

% Paragraphs have a line break after the title
\let\oldparagraph\paragraph
\renewcommand*{\paragraph}[1]{\oldparagraph{#1}\mbox{}\oldbreak}

\makeatletter

\patchcmd\g@matrix
{\vbox\bgroup}
{\vbox\bgroup\normalbaselines}% restore the standard baselineskip
{}{}

\newcommand*{\da@rightarrow}{\mathchar"0\hexnumber@\symAMSa 4B }
\newcommand*{\da@leftarrow}{\mathchar"0\hexnumber@\symAMSa 4C }
\newcommand*{\xdashrightarrow}[2][]{%
  \mathrel{%
    \mathpalette{\da@xarrow{#1}{#2}{}\da@rightarrow{\,}{}}{}%
  }%
}
\newcommand{\xdashleftarrow}[2][]{%
  \mathrel{%
    \mathpalette{\da@xarrow{#1}{#2}\da@leftarrow{}{}{\,}}{}%
  }%
}
\newcommand*{\da@xarrow}[7]{%
  % #1: below
  % #2: above
  % #3: arrow left
  % #4: arrow right
  % #5: space left
  % #6: space right
  % #7: math style
  \sbox0{$\ifx#7\scriptstyle\scriptscriptstyle\else\scriptstyle\fi#5#1#6\m@th$}%
  \sbox2{$\ifx#7\scriptstyle\scriptscriptstyle\else\scriptstyle\fi#5#2#6\m@th$}%
  \sbox4{$#7\dabar@\m@th$}%
  \dimen@=\wd0 %
  \ifdim\wd2 >\dimen@
    \dimen@=\wd2 %
  \fi
  \count@=2 %
  \def\da@bars{\dabar@\dabar@}%
  \@whiledim\count@\wd4<\dimen@\do{%
    \advance\count@\@ne
    \expandafter\def\expandafter\da@bars\expandafter{%
      \da@bars
      \dabar@
    }%
  }%
  \mathrel{#3}%
  \mathrel{%
    \mathop{\da@bars}\limits
    \ifx\\#1\\%
    \else
      _{\copy0}%
    \fi
    \ifx\\#2\\%
    \else
      ^{\copy2}%
    \fi
  }%
  \mathrel{#4}%
}

\renewcommand*\env@matrix[1][*\c@MaxMatrixCols c]{%
  \hskip -\arraycolsep
  \let\@ifnextchar\new@ifnextchar
  \array{#1}}

\makeatother

% lange and rangle scale automatically
\let\oldlangle\langle
\renewcommand{\langle}{\left\oldlangle}

\let\oldrangle\rangle
\renewcommand{\rangle}{\right\oldrangle}

% Point-wise and uniform convergent
\newcommand{\pwto}[2][]{\xdashrightarrow[#1]{#2}}
\newcommand{\unito}[2][]{\xrightarrow[#1]{#2}}

% Infinity norm
\newcommand{\inftynorm}[1]{\left\|#1\right\|_\infty}

% Number sets
\newcommand{\naturals}{\mathbb{N}}
\newcommand{\reals}{\mathbb{R}}
\newcommand{\complex}{\mathbb{C}}
\newcommand{\rationals}{\mathbb{Q}}
\newcommand{\integers}{\mathbb{Z}}

% Set boundary
\newcommand{\bound}{\partial}

% Question group header
\newcommand{\questiongroup}[1]{ \fullwidth{\Large \textbf{#1}}}

% Vector underline shortcut
\newcommand{\ul}[1]{\underline{#1}}

% Linear maps
\newcommand{\map}[1]{\mathcal{#1}}

% Floor and ceil
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}

% Vertical vector
\newcommand{\vvec}[1]{\begin{pmatrix} #1 \end{pmatrix}}

% Equivalent with
\newcommand\equalhat{\mathrel{\stackon[1.5pt]{=}{\stretchto{\scalerel*[\widthof{=}]{\wedge}{\rule{1ex}{3ex}}}{0.5ex}}}}

% Transition matrix
\newcommand{\trans}[3][S]{\ifthenelse{\isempty{#1}}{{}_{#3}S_{#2}}{{}_{#3}#1_{#2}}}

% Vertical bars in gmatrix
\newcommand{\BAR}{%
    \hspace{-\arraycolsep}%
    \strut\unskip\ \vrule \ % the `\vrule` is as high and deep as a strut
    \hspace{-\arraycolsep}%
}
\newcommand{\mbar}{\hspace{-\arraycolsep} \strut\vrule \hspace{-\arraycolsep}}

% Function restrictions
\newcommand\restr[2]{{
	\left.\kern-\nulldelimiterspace % automatically resize the bar with \right
	#1 % the function
	\vphantom{\big|} % pretend it's a little taller at normal size
	\right|_{#2} % this is the delimiter
}}

% Integral d
\renewcommand*\d{\mathop{}\!\mathrm{d}}

% Inline to prove env. To be used when `toprove' is the first content in a question. Then normally the text would end up on a new line, which is ugly. In these cases, use this environment instead.
\makeatletter
\newenvironment{inlinetoprove}
{\enskip\textbf{To prove.\space}}% \begin{inlinetoprove}
{\enskip}% \end{inlinetoprove}
\makeatother

% Command to define question with custom number
\newcommand{\nquestion}[1]{\setcounter{question}{#1 - 1}\question}
\newcommand{\nfirstquestion}[1]{\setcounter{question}{#1 - 1}\firstquestion}

% Let references be with parentheses
\let\oldref\ref
\renewcommand{\ref}[1]{(\oldref{#1})}

\endinput