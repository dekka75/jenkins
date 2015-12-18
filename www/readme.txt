Classe pour poser et valider un formulaire------------------------------------------
Url     : http://codes-sources.commentcamarche.net/source/100816-classe-pour-poser-et-valider-un-formulaireAuteur  : pifou25Date    : 25/11/2014
Licence :
=========

Ce document intitul� � Classe pour poser et valider un formulaire � issu de CommentCaMarche
(codes-sources.commentcamarche.net) est mis � disposition sous les termes de
la licence Creative Commons. Vous pouvez copier, modifier des copies de cette
source, dans les conditions fixées par la licence, tant que cette note
appara�t clairement.

Description :
=============

Bonjour,
<br />
<br />Il peut �tre fastidieux d'�crire un formulaire et le g�r
er correctement. 
<br />Je voudrais donc rendre l'utilisation du formulaire HTM
L plus simple.
<br />
<br />La 1�re version permet de g�rer les balises input 
et textarea de base, et
<br />g�re aussi les tricks antibot 'de base' � savoir 
un token (cl� de cyptage),
<br />une constante 'SALT', ceci pour crypter les no
ms des champs de mani�re dynamique, 
<br />et un pi�ge � bot : un textarea masq
u� (par style css) qui doit rester vide pour
<br />validation du formulaire.
<
br />
<br />L'usage doit rester simple mais aussi flexible. Un petit exemple va
ut mieux 
<br />qu'un long discour :
<br />
<br /><pre class="code" data-mode
="php">
// je d�fini mon formulaire avec des attributs 'en vrac'
$cond = array(

	'nom' =&gt; array('type'=&gt;'text', 'name'=&gt;'nom', 'size'=&gt;18, 'maxlengt
h'=&gt;20, 'value'=&gt;'', 'label'=&gt;array('txt'=&gt;'Nom : ')),
	'email' =&gt
; array('type'=&gt;'text', 'name'=&gt;'email', 'size'=&gt;22, 'maxlength'=&gt;40
, 'value'=&gt;'', 'label'=&gt;array('txt'=&gt;'Email : ')),
    'url' =&gt; arra
y('type'=&gt;'text', 'name'=&gt;'url', 'size'=&gt;25, 'maxlength'=&gt;50, 'value
'=&gt;'http://', 'label'=&gt;array('txt'=&gt;'URL : ')),
	'texto' =&gt; array('t
ype'=&gt;'textarea', 'name'=&gt;'texto', 'cols'=&gt;60, 'rows'=&gt;4, 'wrap'=&gt
;'virtual', 'value'=&gt;''),
	'submit' =&gt; array('type'=&gt;'submit', 'name'=&
gt;'Submit', 'value'=&gt;'Envoyer',
		'label'=&gt;array('txt'=&gt;'Nom et messag
e obligatoires.'))
);
			
$myForm = new form($cond); // form();

if($myForm-&gt;
validateForm()) {
    // formulaire OK
    if (empty($myForm-&gt;nom) || empty($
myForm-&gt;texto))
    {
        // des zones manquantes, msg d'erreur
    }
   
 else
    {
        // ins�rer le msg en bdd avec $myForm-&gt;getValues
        
// ou chaque �l�ment $myForm-&gt;url $myForm-&gt;email etc
    }
}

// afficher 
le formulaire 'en vrac' si le CSS suffit � la mise en forme:
echo $myForm;

// o
u afficher les �l�ments 1 par 1 avec $myForm-&gt;getField($field)
// mais dans c
e cas on doit g�rer les balises &lt;form ... &gt;&lt;/form&gt;

</pre>
<br />

<br />3e solution pour '�crire' le formulaire,  c'est d'�tendre cette classe et 

<br />surcharger la m�thode getForm, comme dans l'exemple comment.form.php
<b
r />cette 2nd classe ajoute des fonctionnalit�s suppl�mentaires:
<br />antifloo
d
<br />captcha
<br />
<br />Une prochaine version prendra en charge les chec
kbox et radio, ainsi que les
<br />listes d�roulantes. Et les fieldset / legend
.
<br />
<br />Et bien sur, toute suggestion est bienvenue!
