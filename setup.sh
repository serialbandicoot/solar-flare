#!/bin/bash

# Function to uninstall packages silently
uninstall_packages() {
    pip uninstall -y "$@"
}

# Function to upgrade pip and install packages from requirements.txt
install_packages() {
    pip install --upgrade pip
    pip install -r requirements.txt
}

# Function to upgrade Keras and Keras-CV
upgrade_packages() {
    pip install ipywidgets
    pip install tensorflow
    pip install --upgrade keras
    pip install --upgrade keras-cv
}

# Function to check Keras version
check_keras_version() {
    local keras_version=$(pip show keras | awk '/^Version:/ { print $2 }')
    local major_version=$(cut -d '.' -f 1 <<< "$keras_version")
    local minor_version=$(cut -d '.' -f 2 <<< "$keras_version")
    local patch_version=$(cut -d '.' -f 3 <<< "$keras_version")
    local keras_float_version="$major_version.$minor_version$patch_version"
    
    echo "Keras version: $keras_version"
    echo "Combined version: $keras_float_version"

    # Check if Keras version is 3 or above
    if (( $(echo "$keras_float_version >= 3.0" | bc -l) )); then
        echo "Keras version $keras_version is 3 or above. Passing."
    else
        echo "Keras version $keras_version is below 3. Aborting."
        exit 1
    fi
}

# Check if Python version is 3.9.18
if [ "$(python3 --version | awk '{print $2}')" != "3.9.18" ]; then
    echo "Python version is not 3.9.18. Installing Python 3.9.18 via Pyenv..."
    pyenv install 3.9.18 || { echo "Error: Failed to install Python 3.9.18 via Pyenv."; exit 1; }
    pyenv local 3.9.18 || { echo "Error: Failed to set local Python version to 3.9.18 via Pyenv."; exit 1; }
fi

# Check if .venv directory exists
if [ -d ".venv" ]; then
    # Switch to .venv directory
    cd .venv || { echo "Error: .venv directory not found."; exit 1; }

    # Activate virtual environment
    source bin/activate || { echo "Error: Failed to activate virtual environment."; exit 1; }

    # Call functions to perform operations
    uninstall_packages keras keras-cv
    install_packages
    upgrade_packages
    check_keras_version

    # Deactivate virtual environment
    deactivate
else
    echo "Creating .venv directory..."
    python3 -m venv .venv || { echo "Error: Failed to create virtual environment."; exit 1; }

    # Execute the script recursively after creating the virtual environment
    "$0"
fi
