\ProvidesClass{dodiresume}[2019/10/11 Simple resume class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\usepackage{fontspec}
\usepackage{polyglossia}
\usepackage{titlesec}
\usepackage{enumitem}
\usepackage{hyperref}
\usepackage{xcolor}
\usepackage{geometry}
\usepackage{setspace}
\usepackage{parskip}
\usepackage{fontawesome5}
\usepackage{booktabs}
\usepackage{fancyhdr}

\definecolor{maincolor}{HTML}{474747}
\definecolor{linkcolor}{HTML}{1589FF}
\definecolor{namecolor}{HTML}{0053A1}

\geometry{a4paper, margin=1.5cm, headheight=0.5cm}

\setdefaultlanguage{russian}
\setotherlanguage{english}
\setmainfont{Noto Sans}[
  Scale = 0.9
]

\hypersetup{
  colorlinks=true,
  linkcolor=linkcolor,
  filecolor=linkcolor,      
  urlcolor=linkcolor,
  pdftitle={Резюме},
  pdfpagemode=FullScreen,
}

\pagestyle{fancy}
\fancyhf{} % clear all header and footer fields
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\titleformat{\section}
  {\Large\bfseries}
  {}{0em}
  {}
  [\titlerule]

\titleformat{\subsection}
  {\bfseries}
  {}{0em}
  {}

\setlist[itemize]{leftmargin=*, noitemsep, topsep=0pt}

\newcommand{\experience}[4]{
  \subsection{#1 — #2}
  #3 \\ 
  \textit{#4} \\
}

\newcommand{\education}[3]{
  \textbf{#1 — #2} \\
  \textit{#3}
}

\newcommand{\project}[2]{
  \textbf{#1} — #2
}

\newcommand{\metadata}[3]{
  \begin{center}
    #1 | #2 | #3
  \end{center}
}