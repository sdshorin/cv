%%=====================================
%% DODI: Don't Over-Design It
%% A resume and CV template made by Garland Culbreth (culbreth.garland@gmail.com)
%% (v1.0.0, 2021-09-04)
%%
%% It is a heavily modified derivative of altacv.cls v1.6.2
%% https://github.com/liantze/AltaCV
%%
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%%
%%=====================================
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{dodiresume}[2021-09-04 DODIresume v1.0.0, a simple two column LaTeX resume, derived from AltaCV v1.6.2.]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\newif\if@raggedtwoe
\DeclareOption{ragged2e}{\@raggedtwoetrue}
%% altacv v1.3: load hyperref for clickable hyperlinks
\newif\if@withhyper
\DeclareOption{withhyper}{\@withhypertrue}
\ProcessOptions\relax

\LoadClass{article}
%% altacv v1.3.2 Hopefully this helps make the PDF
%% file more 'friendly' with copy-paste etc
%% altacv v1.6.1 Temporary fix for pdfx incompatibility; see https://tex.stackexchange.com/a/610445
\RequirePackage{etoolbox}
\@ifl@t@r\fmtversion{2021-06-01}%
    {\AddToHook{package/after/xmpincl}
    {\patchcmd\mcs@xmpincl@patchFile{\if\par}{\ifx\par}{}{\fail}}}{}
\RequirePackage[a-1b]{pdfx}
%% altacv v1.3.3 Temporary fix for pdfx and biblatex incompatibility
%% (Thanks to @badetitou for highlighting this issue)
%% https://github.com/plk/biblatex/issues/1044
%% Will be removed when fix is released in biblatex 3.16
% \catcode30=12
\RequirePackage{accsupp}
\RequirePackage[margin=2cm]{geometry}
\RequirePackage{ifxetex,ifluatex}
\RequirePackage{scrlfile}
\RequirePackage{xparse}

%% altacv v1.1.5: added for convenience
\newif\ifxetexorluatex
\ifxetex
    \xetexorluatextrue
\else
    \ifluatex
        \xetexorluatextrue
    \else
        \xetexorluatexfalse
    \fi
\fi

\ifxetexorluatex
    \RequirePackage{fontspec}
\else
    %% altacv v1.3.2 attempts to make ligatures
    %% copy-paste as normal characters
    \RequirePackage{cmap}
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \input{glyphtounicode}
    \pdfglyphtounicode{f_f}{FB00}
    \pdfglyphtounicode{f_f_i}{FB03}
    \pdfglyphtounicode{f_f_l}{FB04}
    \pdfglyphtounicode{f_i}{FB01}
    \pdfgentounicode=1
\fi

\if@raggedtwoe
    \RequirePackage[newcommands]{ragged2e}
\fi

\if@withhyper
    \AtBeginDocument{%
        \hypersetup{hidelinks}
        \urlstyle{same}}
\fi

\RequirePackage{xcolor}

\definecolor{LightGrey}{HTML}{666666}
\definecolor{BlueBlack}{HTML}{0B5394}
\definecolor{GdocLink}{HTML}{1155CC}
\colorlet{name}{BlueBlack}
\colorlet{tagline}{black}
\colorlet{heading}{BlueBlack}
\colorlet{subheading}{black}
\colorlet{accent}{black}
\colorlet{body}{LightGrey}
\colorlet{link}{GdocLink}
\newcommand{\itemmarker}{{\small\textbullet}}
\newcommand{\ratingmarker}{\faCircle}

\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage[inline]{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vspace{0.25\baselineskip}}
\setlist[itemize]{label=\itemmarker}
\RequirePackage{graphicx}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}
% \RequirePackage{dashrule}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip}

\newenvironment{fullwidth}{%
    \begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}
    {\end{adjustwidth}}

%% altacv v1.3.1 \detokenize will break UTF-8 in pdflatex
%% Using alternative from https://tex.stackexchange.com/a/530911/226
\newcommand{\utffriendlydetokenize}[1]{%
\scantokens{%
    \catcode`\_=12%
    % \catcode`\^=12%
    % \catcode`\{=12%
    % \catcode`\}=12%
    \catcode`\&=12%
    \catcode`\$=12%
    \catcode`\#=12%
    \catcode`\~=12%
    % \catcode`\\=12%
    {#1}}}

%% altacv v1.3: Incorporating hyperlinks
%% altacv v1.3.1: using \unfriendlydetokenize to avoid breaking unicode
%% altacv v1.6: Use accsupp so that when copying/pasting the icon from PDF to a text
%% file, the icon name is pasted
\ExplSyntaxOn
\NewDocumentCommand{\printinfo}{m m o}{%
    \BeginAccSupp{method=escape,ActualText={#1:~#2}}
    \IfNoValueTF{#3}{%
        \mbox{\textcolor{accent}{\normalfont #1}~\utffriendlydetokenize{#2}\hspace{2em}}%
    }{%
    \if@withhyper%
        \mbox{\textcolor{accent}{\normalfont #1}~
        \href{#3}{\utffriendlydetokenize{#2}}\hspace{2em}}
    \else%
        \ClassWarning{Please specify [withhyper] option to enable hyperlinks. Printing out full hyperlink prefix #1 for now.}%
        \mbox{\textcolor{accent}{\normalfont #1}~{\utffriendlydetokenize{#3#2}}\hspace{2em}}%
    \fi%
    }%
    \EndAccSupp{}
}%


%% altacv v1.3: Exploring convenient creation of fields
%% altacv v1.6: Add starred mode to create \printinfo with full URL
\NewDocumentCommand{\NewInfoField}{s m m o}{%
    \IfBooleanF{#1}{
        \IfNoValueF{#4}{\csdef{#2 hyperprefix}{#4}}%
    }
    \csdef{#2 symbol}{#3}%
    \IfBooleanTF{#1}{
        \csdef{#2}##1##2{%
        \if@withhyper
            \IfNoValueTF {##2}
            {\printinfo{\csuse{#2 symbol}}{##1}}%
            {\printinfo{\csuse{#2 symbol}}{##1}[##2]}%
        \else
            \printinfo{\csuse{#2 symbol}}{##1}%
        \fi%
        }
    }{%
    \csdef{#2}##1{%
        \if@withhyper
            \IfNoValueTF {#4}
            {\printinfo{\csuse{#2 symbol}}{##1}}%
            {\printinfo{\csuse{#2 symbol}}{##1}[\csuse{#2 hyperprefix}##1]}%
        \else
            \printinfo{\csuse{#2 symbol}}{##1}%
        \fi%
        }
    }
}
\ExplSyntaxOff

\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}
\NewInfoField{email}{}[mailto:]
\NewInfoField{telegram}{}
\NewInfoField{birth_date}{}
\NewInfoField{phone}{}[tel:]
\NewInfoField{homepage}{}[https://]
\NewInfoField{twitter}{}[https://]
\NewInfoField{linkedin}{}[https://]
\NewInfoField{github}{}[https://]
\NewInfoField{orcid}{}[https://orcid.org/]
\NewInfoField{location}{}

\newcommand{\namefont}{\bfseries\fontsize{36pt}{36pt}\selectfont}
\newcommand{\detaliesfont}{\bfseries\fontsize{9pt}{9pt}\selectfont}
\newcommand{\personalinfofont}{\normalsize}
\newcommand{\cvsectionfont}{\large\bfseries\MakeUppercase}
\newcommand{\cvsubsectionfont}{\normalsize\bfseries}


\newcommand{\makecvheader}{%
    \setlength\tabcolsep{0pt}
    \begin{tabular}{lll}
        \raggedright%
		\begin{tabular}{>{}l}
			\includegraphics[width=0.2\linewidth]{photo.jpg}
		\end{tabular}
        \begin{minipage}{0.47\textwidth}%
            {\namefont\color{name}{\@name}\par}
			\begin{minipage}{0.877\textwidth}%
				{\detaliesfont\color{name}{Game Developer with 3+ year of experience. \\
				Skilled in implementing of algorithms,\\knowledgeable in computer graphic.}\par}
			\end{minipage}
        \end{minipage}
		
        &\begin{tabular}{>{\color{accent}}l}
            \personalinfofont\@personalinfo\par
        \end{tabular}
    \hfill%
    \end{tabular}
    \vspace{6pt}}

\newcommand{\cvsection}[2][]{%
    \nointerlineskip\vspace{18pt}%
    \ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\raggedright\input{#1}}}%
    {\color{heading}\cvsectionfont{#2}}
    \vspace{0pt}}

\newcommand{\cvsubsection}[1]{%
    \vspace{12pt}
    {\color{subheading}\normalsize\bfseries{#1}\par}
    \vspace{6pt}}

\newcommand{\cvevent}[4]{%
    \vspace{6pt}
    {\color{accent}\textbf{#1}}
    \ifstrequal{#2}{}{}{\textit{\color{accent}--~#2,}}
    \ifstrequal{#3}{}{}{{\color{accent}#3}}
    \par
    \ifstrequal{#4}{}{}{{\small\makebox[0.5\linewidth][l]{\MakeUppercase{#4}}}}
    \normalsize\par}

\newcommand{\cvproject}[4]{
    \vspace{6pt}
    {\color{accent}\normalsize\textbf{#1}}\par
    {\small\MakeUppercase{#2~--~}\textit{#3}}\par
    \ifstrequal{#4}{}{}{\href{#4}{\small\color{GdocLink}\underline{Source code}}\par}}
    
\newcommand{\cvpub}[4]{
    \vspace{6pt}
    {\color{accent}\normalsize\textbf{#1}}\par
    {\small\MakeUppercase{#2~--~}\textit{#3}}\par
    \ifstrequal{#4}{}{}{\href{https://doi.org/#4}{\small\color{GdocLink}\underline{doi:#4}}\par}}
    
\newcommand{\cvgscholar}[4]{
    \vspace{6pt}
    {\color{accent}\normalsize\textbf{#1}}\par
    {\small{h-index:~#2, citations:~#3}}\par
    \ifstrequal{#4}{}{}{\href{https://scholar.google.com/citations?user=#4}{\small\color{GdocLink}\underline{profile link}}\par}}

\newcommand{\cvaward}[3]{
    \vspace{6pt}
    {\color{accent}\normalsize\textbf{#1}}\par
    {\small\textit{#2}}\par
    {\small\MakeUppercase{#3}}\par}

\newcommand{\cvinvolve}[3]{
    \vspace{6pt}
    {\color{accent}\normalsize\textbf{#1}}\par
    {\small\MakeUppercase{#2}}\par
    \ifstrequal{#3}{}{}{\small\textit{#3}}\par}

\newcommand{\cvskill}[1]{
    \small{#1}\par}

\newcommand{\cvref}[5]{%
    \vspace{6pt}
    \textcolor{accent}{\normalsize\textbf{#1},~#2}\par
    {\textit{#3,~#4}}\par
    {\href{mailto:#5}{\color{GdocLink}\underline{#5}}}\par}

\newenvironment{cvcolumn}[1]{\begin{minipage}[t]{#1}\raggedright}{\end{minipage}}

\AtBeginDocument{%
    \pagestyle{empty}
    \color{body}
    \raggedright}
