<?php

/**
 * @license    GPL 2 (http://www.gnu.org/licenses/gpl.html)
 * 
 * @author soer9648 <soer9648@eucl.dk>
 * @author Søren Birk <soer9648@eucl.dk>
 * @author Jacob Palm <mail@jacobpalm.dk>
 */
$lang['pagesize']              = 'Sideformatet som supporteres af mPDF. Som regelt <code>A4</code> eller <code>letter</code>.';
$lang['orientation']           = 'Sideretning.';
$lang['orientation_o_portrait'] = 'Portræt';
$lang['orientation_o_landscape'] = 'Landskab';
$lang['toclevels']             = 'Definer øverste og maksimale niveau som tilføjes til indholdsfortegnelsen. Standard wiki niveauer for indholdsfortegnelse (<a href="#config___toptoclevel">toptoclevel</a> og <a href="#config___maxtoclevel">maxtoclevel</a>) benyttes. Format: <code><i>&lt;top&gt;</i>-<i>&lt;maks&gt;</i></code>';
$lang['maxbookmarks']          = 'Hvor mange sektion-niveauer skal benyttes i PDF-bogmærkerne? <small>(0=ingen, 5=alle)</small>';
$lang['template']              = 'Hvilken skabelon skal benyttes til formatering af PDF\'erne?';
$lang['output']                = 'Hvordan skal PDF\'en præsenteres for brugeren?';
$lang['output_o_browser']      = 'Vis i browser';
$lang['output_o_file']         = 'Download PDF\'en';
$lang['usecache']              = 'Skal PDF\'er cachelagres? Indlejrede billeder bliver ikke kontrolleret af ACL, deaktivér hvis det er et sikkerhedsproblem for dig.';
$lang['usestyles']             = 'Du kan angive en kommasepareret liste over plugins hvor <code>style.css</code> eller <code>screen.css</code> skal benyttes til generering af PDF.';
$lang['qrcodesize']            = 'Størrelse på indlejrede QR-kode (i pixels <code><i>bredde</i><b>x</b><i>højde</i></code>). Efterlad tomt for at deaktivere';
$lang['showexportbutton']      = 'Vis PDF eksportknap (kun hvis det er supporteret af din skabelon)';
