# Mac Setup

This repo will automatically setups a mac with the applications which i use on a daily basis.

Make sure you are logged in to apple App Store. Mas-cli tool needs user authentication from the app store to install app store apps.

To run use `./install.sh`

## iTerm2 ZSH setup

Settings file

Copy manually `templates/cobalt2.zsh-theme` to `~/.oh-my-zsh/themes/`

## Git manual setup

- git log styling

```
git config --global pretty.my format:'%C(yellow)%h %C(dim green)%ad %C(reset)| %C(cyan)%s%d %C(#667788)[%an]' --date=format:'%F %R'
git config --global format.pretty my


// Windows additional step
git config --global log.date format-local:'%F %R’
```

- manage multiple git accounts

```
// location -> ~/Users/{username}/.ssh/.ssh

#SSH config for multiple git hosting accounts

# Personal github account
Host github.com
 HostName github.com
 User maz4
 IdentityFile ~/.ssh/id_rsa_github

# Work gitlab account
Host gitlab.com
 HostName gitlab.com
 User Marcin
 IdentityFile ~/.ssh/id_rsa_gitlab
```

required files

- ~/Users/{user}/.ssh/id_rsa_github - rsa private key
- ~/Users/{user}/.ssh/id_rsa_github.pub - ssh-rsa

- ~/Users/{user}/.ssh/id_rsa_gitlab - rsa private key
- ~/Users/{user}/.ssh/id_rsa_gitlab.pub - ssh-rsa

## VS code setup

### Launching from the command line

[vs code docs](https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line)

```
cat << EOF >> ~/.zprofile
# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF
```

### VS code settings

Open Settings (JSON) -> Command + Shift + P -> type Open Settings (JSON) -> paste in bellow json

```
{
 "workbench.iconTheme": "vscode-icons",
 "workbench.colorCustomizations": {
   "statusBar.background": "#333333",
   "statusBarItem.remoteBackground": "#333333"
 },
 "editor.minimap.enabled": false,
 "[javascript]": {
   "editor.defaultFormatter": "esbenp.prettier-vscode"
 },
 "[javascriptreact]": {
   "editor.defaultFormatter": "esbenp.prettier-vscode"
 },
 "editor.fontFamily": "Menlo, Monaco, 'Courier New', monospace, Droid Sans Mono Dotted for Powerline",
 "[json]": {
   "editor.defaultFormatter": "esbenp.prettier-vscode"
 },
 "javascript.updateImportsOnFileMove.enabled": "always",
 "editor.suggestSelection": "first",
 "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
 "cSpell.userWords": [],
 "[typescript]": {
   "editor.defaultFormatter": "esbenp.prettier-vscode"
 },
 "editor.tabSize": 2,
 "[jsonc]": {
   "editor.defaultFormatter": "esbenp.prettier-vscode"
 },
 "[typescriptreact]": {
   "editor.defaultFormatter": "esbenp.prettier-vscode"
 },
 "workbench.startupEditor": "newUntitledFile",
 "[css]": {
   "editor.defaultFormatter": "esbenp.prettier-vscode"
 },
 "liveshare.authenticationProvider": "GitHub",
 "[html]": {
   "editor.defaultFormatter": "esbenp.prettier-vscode"
 },
 "svelte.enable-ts-plugin": true,
 "[svelte]": {
   "editor.defaultFormatter": "svelte.svelte-vscode"
 },
 "vscode-edge-devtools.mirrorEdits": true,
 "editor.defaultFormatter": "esbenp.prettier-vscode",
 "editor.formatOnSave": true,
 "explorer.confirmDelete": false
}

```

### VS code extensions

ToDo

automate installation with ansible

```
code --install-extension aaravb.chrome-extension-developer-tools
code --install-extension adamhartford.vscode-base64
code --install-extension dbaeumer.vscode-eslint
code --install-extension eamodio.gitlens
code --install-extension ecmel.vscode-html-css
code --install-extension esbenp.prettier-vscode
code --install-extension formulahendry.auto-rename-tag
code --install-extension frhtylcn.aws-sdk-snippets
code --install-extension johnpapa.vscode-peacock
code --install-extension jpoissonnier.vscode-styled-components
code --install-extension lucax88x.codeacejumper
code --install-extension mgmcdermott.vscode-language-babel
code --install-extension msjsdiag.debugger-for-edge
code --install-extension naumovs.color-highlight
code --install-extension pflannery.vscode-versionlens
code --install-extension robinbentley.sass-indented
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension svelte.svelte-vscode
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension WallabyJs.quokka-vscode
code --install-extension Zignd.html-css-class-completion
```

## Apps to install manually

- OpenVPN
