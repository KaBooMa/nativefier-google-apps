# Test for nativefier (Requirement)
if ! command -v nativefier &> /dev/null
then
    echo "This script uses nativefier to create wrapper apps for the Google suite. Can we install nativefier using brew?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) 
            if ! command -v brew &> /dev/null
            then
                echo "Brew not installed. Please install brew first: https://brew.sh/"
                exit
            fi; 
            brew install nativefier
            break;;
            No ) exit;;
        esac
    done
fi

nativefy_app() {
    echo "Nativefying Google $2..."
    nativefier "$1" /Applications/Google/ -n "$2" --honest --single-instance &> /dev/null
    mv "/Applications/Google/$2-darwin-arm64/$2.app" "/Applications/Google/$2.app"
    rm -rf "/Applications/Google/$2-darwin-arm64"
}

# Create directory and use nativefier for each app
echo 'Creating Google folder in Applications'
mkdir /Applications/Google
nativefy_app 'https://keep.google.com/' 'Keep'
nativefy_app 'https://messages.google.com/' 'Messages'
nativefy_app 'https://gmail.com/' 'Gmail'
nativefy_app 'https://sheets.google.com/' 'Sheets'
nativefy_app 'https://calendar.google.com/' 'Calendar'
nativefy_app 'https://photos.google.com/' 'Photos'
nativefy_app 'https://slides.google.com/' 'Slides'
nativefy_app 'https://docs.google.com/' 'Docs'
nativefy_app 'https://contacts.google.com/' 'Contacts'