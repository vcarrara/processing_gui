import controlP5.*;

// Constantes de configuration
final String USERNAME = "robert";
final String PASSWORD = "robert";

// Variable ControlP5 pour créer l'interface graphique
ControlP5 cp5;
// Groupe qui contient les composants graphique
// Il est plus simple de supprimer un groupe qui contient des composants que de supprimer les composants uns par uns
Group mainPanel;
// Etat courant de l'application
ApplicationState state = ApplicationState.LOGIN_FORM;
// Utitilisateur courant de l'application
User currentUser;

void setup() {
  size(800, 600);
  noStroke();
  // Création de l'instance de ControlP5 et du Main Panel associé
  cp5 = new ControlP5(this);
  // Affichage de la fenêtre correspondant à l'état initial
  showFrame(state);
}

void draw() {
  switch (state) {
  case PAINT_FRAME:
    stroke(cp5.get(ColorPicker.class, "picker").getColorValue());
    // stroke(255);
    if (mousePressed == true) {
      line(mouseX, mouseY, pmouseX, pmouseY);
    }
    break;
  }
}

// Fonction qui supprime le panel principal et le recrée
// Permet de "partir d'une fenêtre vide"
void reset() {
  final String PANEL_NAME = "MainPanel";
  if (mainPanel != null) {
    mainPanel.remove();
  }
  mainPanel = cp5.addGroup(PANEL_NAME);
  background(0);
}

// Affiche la fenêtre correspondant à l'état passé en paramètre
// Change l'état courant par l'état passé en paramètre
void showFrame(ApplicationState _state) {
  reset();
  state = _state;
  switch (state) {
  case LOGIN_FORM:
    drawLoginForm();
    break;
  case MAIN_MENU:
    drawMainMenu(currentUser);
    break;
  case PAINT_FRAME:
    drawPaintFrame(currentUser);
    break;
  }
}

// Fonction qui permet de dessiner le formulaire de connexion
void drawLoginForm() {
  cp5.addTextfield("Utilisateur")
    .setPosition(100, 100)
    .setSize(600, 30)
    .setFocus(true)
    .setGroup(mainPanel);

  cp5.addTextfield("Mot de passe")
    .setPosition(100, 160)
    .setSize(600, 30)
    .setPasswordMode(true)
    .setGroup(mainPanel);

  cp5.addButton("Valider")
    .setPosition(100, 220)
    .setSize(100, 30)
    .setGroup(mainPanel)
    .onPress(new CallbackListener() {
    public void controlEvent(CallbackEvent e) {
      // Récupération des identifiants de connexion
      final String username = cp5.get(Textfield.class, "Utilisateur").getText();
      final String password = cp5.get(Textfield.class, "Mot de passe").getText();

      // Si les identifiants sont corrects
      if (USERNAME.equals(username) && PASSWORD.equals(password)) {
        currentUser = new User(username);
        showFrame(ApplicationState.MAIN_MENU);
      }
    }
  }
  );
}

// Fonction qui permet de dessiner le menu principal
void drawMainMenu(User user) {
  final User _user = user;

  cp5.addLabel("UsernameTextfield")
    .setPosition(100, 100)
    .setSize(200, 40)
    .setText("Bienvenue " + _user.getUsername() + " !")
    .setGroup(mainPanel);

  cp5.addButton("New Project")
    .setPosition(650, 100)
    .setSize(100, 30)
    .setGroup(mainPanel)
    .onPress(new CallbackListener() {
    public void controlEvent(CallbackEvent e) {
      showFrame(ApplicationState.PAINT_FRAME);
    }
  }
  );

  cp5.addButton("Deconnexion")
    .setPosition(650, 500)
    .setSize(100, 30)
    .setGroup(mainPanel)
    .onPress(new CallbackListener() {
    public void controlEvent(CallbackEvent e) {
      currentUser = null;
      showFrame(ApplicationState.LOGIN_FORM);
    }
  }
  );
}

void drawPaintFrame(User user) {
  final User _user = user;

  cp5.addButton("Sauvegarder")
    .setPosition(50, 50)
    .setSize(100, 30)
    .setGroup(mainPanel)
    .onPress(new CallbackListener() {
    public void controlEvent(CallbackEvent e) {
      // TODO
    }
  }
  );

  cp5.addButton("Annuler")
    .setPosition(200, 50)
    .setSize(100, 30)
    .setGroup(mainPanel)
    .onPress(new CallbackListener() {
    public void controlEvent(CallbackEvent e) {
      showFrame(ApplicationState.MAIN_MENU);
    }
  }
  );

  cp5.addColorPicker("picker")
    .setPosition(350, 50)
    .setColorValue(color(255, 128, 0, 128))
    .setGroup(mainPanel);
}
