import "package:flutter/material.dart";

//colors
const Color navyColor = Color(0xff1d385c);
const Color splashScreenNavyColor = Color(0xff2d5687);
Color navyColorWithOpacity = const Color(0xff1d385c).withOpacity(0.4);
const Color whiteColor = Color(0xffffffff);
 Color goldColor = const Color(0xff8F7A3F).withOpacity(0.7);
 Color goldColorWithOpacity = const Color(0xff8F7A3F).withOpacity(0.4);

//STRINGS

//Common Strings

const isLoading = "Chargement en cours";

const String mainAppBarTitle = "Bienvenue";
const String search = "Rechercher";
const String search1 = "Saisir la commune";
const String search2 = "Saisir le quartier";
const String adNews = "Publicité";
const String localization = "Zone de recherche";
const String localization2 = "Localisation";
const contactUS = "Contactez nous";
const seeJobOffers = "Voir les offres d’emplois";

//Splash Screen
const String appTitle = "ATALAKOU";
// const String launchBy = "Launch by KÔKÔ";
//On Boarding Screen

const String onBoardingDescription1 = "Atalakou vous aide gratuitement à trouver le service que vous recherchez";
const String onBoardingDescription2 = "Atalakou vous aide à trouver un emploi ou des clients pour votre activité";
const String onBoardingDescription3 = " Contactez directement les professionnels qu’il vous faut";

// Choose Profile Screen

const String chooseProfileAppBarTitle = "Choisissez votre profil";

const String specialistTitle = "Je cherche un spécialiste";
const String specialistDescription = "Cliquez pour parcourir la liste des meilleurs spécialistes près de chez moi et je les contacte";

const String employTitle = "Je cherche un emploi";
const String employDescription = "Cliquez pour rentrer en contact avec nos équipes";

const String customerBaseTitle = "Je cherche à accroître ma clientèle";
const String customerBaseDescription = "Cliquez pour rentrer en contact avec nos équipes";

//NAVIGATION BARS

//Common
const String home = "Accueil";
const String profile = "Profil";
const none = "Aucun";

//Services
const String favorites = "Favoris";

//Jobs + Customer Base
const String messages = "Messages";

//LOOKING FOR SERVICES

//Main Screen

const String artisans = "Artisans";
const String maison = "Maison";
const String voiture = "Voiture";
const String beaute = "Bien-etre";
const String evenementiel = "Evènementiel";
const searchForCommunityFirst = "Sélectionnez d'abord la communauté";
const noCategoryAvailable = "Aucune catégorie disponible";

//Sub Category Result Screen
const String resultsScreenAppBarTitle = "Résultats";
const String serviceTileTitle = "Nom et Prénom";
const String serviceTileDomain = "Métier";

//Result Detail + Rate Service Screen

const addedToFavorites = "Ajouté aux favoris";
const removedFromFavorites = "Retiré des favoris";
const resultDetailScreenAppBarTitle = "Détails";
const rateServiceScreenAppBarTitle = "Notation";
const namePlaceholder = "Nom et Prénom";
const domainPlaceholder = "Spécialité";
const notePlaceholder = "Note";
const activityInfoHeading = "Information sur l’activité";
const examplesHeading = "Exemple de réalisation";

const addToFavTitle = "Ajouter aux favoris";
const connectTitle = "Mise en contact";
const rateServiceTitle = "Noter la prestation";
const submitRatingValidation = "noter les étoiles et écrire un avis";
const alreadyRated = "L'utilisateur a déjà évalué cet expert.";
const thankYouForFeedback = "Merci pour votre avis ! Votre évaluation a été enregistrée avec succès.";
//Rating Stars

const oneStar = "Mauvais";
const twoStar = "Médiocre";
const threeStar = "Bon";
const fourStar = "Très bon ";
const fiveStar = "Excellent";

//Connecting Bottom Sheet
const callBottomSheetDescription = "Mise en contact avec le prestataire";
const cancelCall = "Annuler";
const proceedWithCall = "Appeler";

//rate Screen
const rateServiceString = "Comment noteriez-vous l’expérience et le service ?";
const comment = "Commentaires :";
const submit = "Envoyer";

//Favorites screen
const signInToSeeFavorites = "Connectez-vous pour voir vos favoris";

//LOOKING FOR JOB SCREENS

//Job Offers Screen
const jobOffersAppBarTitle = "Offres d’emploi";
const jobDomainLabel = "Métier";
const cityLabel = "Ville";

const typeOfIndustry = "Secteur d’activité";
const typeOfJob = "Type d’emploi";
const dateOfCreation = "Date de parution";

//Job Detail Screen
const jobDescriptionHeading = "Descriptif de l’offre";
const applyButtonContent = "Postuler";
const noJobFound = "Aucune offre d'emploi trouvée";
const noExpertsFound = "Aucun spécialiste trouvé";
const searchForJobs = "Rechercher pour voir les offres d'emploi";
const alreadyApplied = "Candidature déjà envoyée";

//Profile Page Screen
const String profileDeleteBottomScreenText = "Êtes vous sûr de vouloir \nla suppression de votre compte ? \nVous perdrez tous vos favoris.";
const deleteAccount = "Supprimer mon compte";
const signOut = "Se déconnecter";
const subscriptionEnd = "Fin abonnement :";


//AUTHENTICATION SCREENS

const signUp = "Je m’inscris";
const logIn = "Je me connecte";

//Common
const email = "Adresse Email ";
const password = "Mot de passe";

//Log In Screen
const logInGreetings = "Heureux de vous revoir !";
const forgottenPassword = "Mot de passe oublié?";
const noAccount = "Vous n’avez pas de compte ?";
const signUpTextButton = "Inscrivez-vous";
const loginButton = "Connexion";

//Sign Up Screen
const signUpTitle = "Créez un compte";
const createPassword = "Créer votre mot de passe";
const createPasswordHintText = "Il doit contenir au moins 8 caractères";
const confirmPassword = "Confirmer votre mot de passe ";
const confirmPasswordHintText = "Ressaisir votre mot de passe ";
const acceptTerms = "J’ai lu et j’accepte CGU et politique de confidentialité";
const accountExists = "Vous avez un compte ?";
const logInTextButton = "Se connecter";

//Reset Password Screen

const resetPasswordTitle = "Vous avez oublié votre mot de passe";
const resetPasswordGreetings = "Pas d’inquiétude ! Cela arrive. Veuillez saisir l’email associé à votre compte.";
const emailHintText = "Entrer votre adresse Email";

//Authentication Toasts

const emailInUse = "L’adresse email est déjà utilisée";
const emailInvalid = "L’adresse email n’est pas valide";
const errorOccurred = "Une erreur s’est produite";
const emailIncorrect = "L’adresse email saisie n’est pas correcte";
const userDisabled = "Le compte est désactivé";
const userNotFound = "Le compte n’existe pas";
const wrongPassword = "Le mot de passe saisi n’est pas correct";
const resetLinkSent = "Le lien de réinitialisation du mot de passe a été envoyé ! Vérifier vos emails";
const logoutSuccess = "Déconnexion réussie";
const loginSuccess = "Connexion réussie";
const logoutConfirmation = "Êtes vous sûr de vouloir vous déconnecter";
const passwordsDoNotMatch = "Les mots de passe saisis ne correspondent pas";
const mustAcceptTerms = "Les conditions d’utilisation doivent être acceptées";
const signUpSuccess = "Le compte a été créé ! Vous pouvez vous connecter maintenant";
const deleteSuccess = "Suppression du compte réussie";
const emailVerificationLinkSent = "Le lien de vérification vous a été envoyé par email";
const emailLinkTimeOut = "Délai d'attente dépassé, veuillez vous inscrire à nouveau.";

//Launch URL
const whatsAppError = "Désolé, une erreur est survenue lors de la récupération du numéro. Nouvel essai...";
const whatsAppRedirect = "Redirection vers l’application WhatsApp";
final whatsApp = Uri.parse('https://wa.me/+923335954599');
final callPhone = Uri.parse('tel:923335954599');
Uri getWhatsapp(String number) => Uri.parse('https://wa.me/+923335954599');
Uri getPhoneNumber(String number) => Uri.parse('tel:$number');