#!/bin/bash
#cd /some/work/path

## Settings
ODOO_BRANCHES=(10.0)  # update if needed
GITHUB_USER=albre116  # change it to your user

## Common functions
function init_repo {
  MAIN=$1
  NAME=$2
  if [ ! -d $NAME ]; then
    # clone
    git clone https://github.com/${MAIN}/${NAME}.git $NAME
    # rename
    git -C $NAME remote rename origin upstream
  fi

  # NAME origin over ssh
  git -C $NAME remote add origin git@github.com:${GITHUB_USER}/${NAME}.git

  for b in "${ODOO_BRANCHES[@]}"
  do
    DEST=odoo-$b/$NAME

    if [ ! -d $DEST ]; then
      # copy
      cp -r $NAME $DEST
      # checkout to branch
      git -C $DEST checkout upstream/$b
    fi
  done

  # clean up
  rm -rf $NAME
}


## Create folder odoo-$b for each branch
for b in "${ODOO_BRANCHES[@]}"
do
  mkdir -p odoo-$b
done

## Clone odoo
init_repo odoo odoo

## Clone IT_PROJECTS_LLC_REPOS
IT_PROJECTS_LLC_REPOS=(
"pos-addons"
"access-addons"
"website-addons"
"misc-addons"
"mail-addons"
"odoo-saas-tools"
"odoo-telegram"
)

for r in "${IT_PROJECTS_LLC_REPOS[@]}"
do
  init_repo it-projects-llc $r
done

## Clone addons-dev
init_repo it-projects-llc addons-dev
for b in "${ODOO_BRANCHES[@]}"
do
  git -C odoo-$b/addons-dev/ remote add misc-addons       https://github.com/it-projects-llc/misc-addons.git
  git -C odoo-$b/addons-dev/ remote add pos-addons        https://github.com/it-projects-llc/pos-addons.git
  git -C odoo-$b/addons-dev/ remote add mail-addons       https://github.com/it-projects-llc/mail-addons.git
  git -C odoo-$b/addons-dev/ remote add access-addons     https://github.com/it-projects-llc/access-addons.git
  git -C odoo-$b/addons-dev/ remote add website-addons    https://github.com/it-projects-llc/website-addons.git
  git -C odoo-$b/addons-dev/ remote add l10n-addons       https://github.com/it-projects-llc/l10n-addons.git
done
