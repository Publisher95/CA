%%
%% CISXXX.cls version 0.2
%% cisXXX  - Latex2e document class for typesetting homework solutions in
%%           CIS-XXX at UPenn, Summer 2016.
%% Copyright (C) 2016, Sanjeev Khanna and Jake Hart.
%%
%% LICENSE:
%%
%% This work may be distributed and/or modified under the conditions of the 
%% LaTeX Project Public License, either version 1.3 of this license or (at
%% your option) any later version. 
%%
%% The latest version of this license is in:
%% http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX version 
%% 2005/12/01 or later.
%%
%% CHANGELOG
%%
%% Fixed undefined reference to \theHWPartners if no partners exist.
%%

%% ============================================================
\NeedsTeXFormat{LaTeX2e}[2005/12/01]
\ProvidesClass{cisXXX}[2016/07/05 CIS XXX Standard LaTeX document class]

\LoadClass[a4paper, oneside, 11pt]{article}[2005/09/16]
%% ============================================================

%%
%% Margins of Text Pages
%%
\RequirePackage[head=2cm, bottom=2.5cm, left=2.5cm, right=2.5cm]{geometry}
%%
%% ============================================================

%%
%% Authors and Partners
%%
% \HWauthor{Name}{e-mail}: your name and school e-mail.
% \HWno:                   which homework is it?
% \HWcourse:               the course you are submitting to (cis-XXX).
\RequirePackage{ifthen}
\makeatletter
\newcommand{\HWauthor}[2]{%
  \ifthenelse{\isundefined{\theHWauthors}}{%
    \def\theHWauthors{#1\\#2}
  }%
  {%
    \g@addto@macro\theHWauthors{\and #1\\#2}
  }
  \ifthenelse{\isundefined{\theHWauthorsatheader}}{%
    \def\theHWauthorsatheader{#1}
  }%
  {%
    \g@addto@macro\theHWauthorsatheader{, #1}
  }
}
\newcommand{\HWno}[1]{%
  \ifthenelse{\isundefined{\theHWno}}{%
    \def\theHWno{#1}
  }%
  {%
    \let\theHWno{#1}
  }
}
\newcommand{\HWcourse}[1]{%
  \ifthenelse{\isundefined{\theHWcourse}}{%
    \def\theHWcourse{#1}
  }%
  {%
    \let\theHWcourse{#1}
  }
}
\newcommand{\HWextension}{%
  \def\theHWextension{Yes}
}
\makeatother
% \HWpartner{Name}: Declare somebody you worked with on the homework.
%                   For multiple partners, just use the \partner command 
%                   multiple times. Relative ordering is preserved.
\makeatletter
\newcommand{\HWpartner}[1]{%
  \ifthenelse{\isundefined{\theHWpartners}}{%
    \def\theHWpartners{#1}
  }%
  {%
    \g@addto@macro\theHWpartners{, #1}
  }
}
\makeatother
%%
%% ============================================================

%%
%% Problem Numbering and Sectioning
%%

\RequirePackage{titlesec}

\newcounter{theHWproblem}
\setcounter{theHWproblem}{1}
\newcounter{theHWsubproblem}[theHWproblem]

\newcommand{\HWproblem}{%
  \subsection*{Problem \arabic{theHWproblem}}
  \addtocounter{theHWproblem}{1}
  \setcounter{theHWsubproblem}{1}
}

\titleformat{\subsubsection}[runin]{\bfseries}{}{}{}[)]

\newcommand{\HWsubproblem}{%
  \subsubsection*{\alph{theHWsubproblem}}
  \addtocounter{theHWsubproblem}{1}
}

%% ============================================================

%%
%% Custom Numbering and Sectioning and also notes sections
%% ADDED BY DAVID GONZALEZ SUA

\newcounter{chapterNum}
\setcounter{chapterNum}{0}
\newcounter{taskNum}[chapterNum]
\newcounter{chapSecNum}[chapterNum]   % NEW: independent of taskNum, resets per chapter

\titleformat{\subsubsection}[runin]{\bfseries}{}{}{}[)]

% NEW: standalone heading style for chapter sections (not run-in, unlike Task)
\titleformat{\paragraph}{\bfseries\large}{}{0pt}{}
\titlespacing*{\paragraph}{0pt}{1.5em}{0.5em}

\newcommand{\Chapter}[1]{%
  \subsection*{Chapter \arabic{chapterNum}: #1}
  \addtocounter{chapterNum}{1}
  \setcounter{taskNum}{1}
  \setcounter{chapSecNum}{1}
}

\newcommand{\ChapterSection}[1]{%
  \paragraph*{\number\numexpr\value{chapterNum}-1\relax.\arabic{chapSecNum}: #1}
  \addtocounter{chapSecNum}{1}
}

\newcommand{\Task}{%
  \subsubsection*{Task \arabic{taskNum}}
  \addtocounter{taskNum}{1}
}

%% ============================================================
%% ADDED BY DAVID GONZALEZ
%% Notes environment
%% Usage:
%%   \begin{notes}          -> freestanding note
%%   \begin{notes}[chapter] -> tagged with current chapter
%%   \begin{notes}[task]    -> tagged with current chapter + task
%% ============================================================
\usepackage{framed}   % gives us the left-bar mechanism
\usepackage{xcolor}   % for the (subtle) gray bar color
\usepackage{etoolbox} % for \ifstrequal, to read the optional arg

\definecolor{notesbar}{gray}{0.55}

\newenvironment{notes}[1][]{%
  \noindent
  \def\FrameCommand{{\color{notesbar}\vrule width 2pt}\hspace{8pt}}%
  \MakeFramed{\advance\hsize-\width \FrameRestore}%
  \small\itshape
  \textbf{\upshape Notes%
    \ifstrequal{#1}{chapter}%
      {\ (Chapter \number\numexpr\value{chapterNum}-1\relax)}%
      {\ifstrequal{#1}{task}%
        {\ (Chapter \number\numexpr\value{chapterNum}-1\relax,%
             \ Task \number\numexpr\value{taskNum}-1\relax)}%
        {}%
      }%
  :}\ 
}{%
  \par
  \endMakeFramed
}

%% ============================================================

%%
%% Headers and Footers of Text Pages
%%
\RequirePackage{fancyhdr}

\pagestyle{fancy}
\fancyhead[R]{\theHWauthorsatheader}
\fancyhead[C]{\theHWcourse}
\fancyhead[L]{Homework \theHWno}
\fancyfoot[R]{}
\fancyfoot[C]{\thepage}
\fancyfoot[L]{}
%%
%% ============================================================

%%
%% Title
%%
\let\oldmaketitle\maketitle
\renewcommand{\maketitle}{%
  \author{\theHWauthors}
  \title{\theHWcourse{} -- Solutions Journal \theHWno}
  \oldmaketitle
  \begin{center}
    \ifthenelse{\isundefined{\theHWextension}}{}{%
      {\Large Using Extension.}

    }
    \ifthenelse{\isundefined{\theHWpartners}}{}{%
      {Partners: \theHWpartners.}
    }

  \end{center}
}
%%
%% ============================================================
