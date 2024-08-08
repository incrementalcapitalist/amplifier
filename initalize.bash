#!/bin/bash

# Initialize (AWS Amplify Setup Script Selector)
# Version: 1.0
# Author: Incremental Capitalist
# Date: Thursday, August 8th, 2024

# Description:
# This script serves as a selector for initializing AWS Amplify projects, offering options
# for both Generation 1 (Gen 1) and Generation 2 (Gen 2) Amplify setups. It guides users
# through the selection process and provides information about each option.
#
# Gen 1 Amplify:
# - Traditional setup with a more hands-on approach
# - Suitable for existing projects or those requiring specific Gen 1 features
# - Provides full control over the Amplify backend configuration
#
# Gen 2 Amplify:
# - Latest version with improved developer experience
# - Recommended for new projects wanting to leverage the latest features
# - Offers streamlined workflows and enhanced performance
# - Requires an existing Amplify app in the AWS console before initialization

# Function to display script header
display_header() {
    echo "================================================="
    echo "       AWS Amplify Setup Script Selector         "
    echo "================================================="
    echo
}

# Function to display script description
display_description() {
    echo "This script helps you choose between Gen 1 and Gen 2 AWS Amplify setups."
    echo
    echo "Gen 1 Amplify:"
    echo "- Traditional setup with more manual configuration"
    echo "- Suitable for existing projects or specific Gen 1 feature requirements"
    echo "- Provides full control over the Amplify backend configuration"
    echo
    echo "Gen 2 Amplify:"
    echo "- Latest version with improved developer experience"
    echo "- Recommended for new projects leveraging latest features"
    echo "- Offers streamlined workflows and enhanced performance"
    echo "- Requires an existing Amplify app in the AWS console before initialization"
    echo
    echo "Choose Gen 2 if you're starting a new project and want the latest features."
    echo "Choose Gen 1 if you're working with an existing Gen 1 project or need specific Gen 1 capabilities."
    echo
}

# Function to get user choice
get_user_choice() {
    echo "Please select your Amplify setup option:"
    echo "1) Set up a Gen 1 Amplify project"
    echo "2) Set up a Gen 2 Amplify project"
    read -p "Enter your choice (1 or 2): " choice
    echo
}

# Function to display example for Gen 1 setup
display_gen1_example() {
    echo "Example: Creating a basic TypeScript/React webapp with Gen 1 Amplify"
    echo "----------------------------------------------------------------"
    echo "1. Create a new React app with TypeScript:"
    echo "   npx create-react-app my-gen1-app --template typescript"
    echo "   cd my-gen1-app"
    echo
    echo "2. Initialize Amplify in your project:"
    echo "   amplify init"
    echo "   (Follow the prompts to configure your project)"
    echo
    echo "3. Add authentication:"
    echo "   amplify add auth"
    echo "   (Choose default configuration or customize as needed)"
    echo
    echo "4. Add API (optional):"
    echo "   amplify add api"
    echo "   (Select 'GraphQL', then follow prompts to set up your API)"
    echo
    echo "5. Push your changes to deploy Amplify backend:"
    echo "   amplify push"
    echo
    echo "6. Generate the necessary code for your app:"
    echo "   amplify codegen"
    echo
    echo "7. Use Amplify in your React app:"
    echo "   // In your src/index.tsx"
    echo "   import { Amplify } from 'aws-amplify';"
    echo "   import awsconfig from './aws-exports';"
    echo "   Amplify.configure(awsconfig);"
    echo
    echo "   // In your components"
    echo "   import { Auth } from 'aws-amplify';"
    echo "   // Use Auth.signIn(), Auth.signOut(), etc."
    echo
}

# Function to display example for Gen 2 setup
display_gen2_example() {
    echo "Example: Creating a basic TypeScript/React webapp with Gen 2 Amplify"
    echo "----------------------------------------------------------------"
    echo "1. Create an Amplify App in the AWS Console"
    echo "   - Go to AWS Amplify Console"
    echo "   - Click 'New app' > 'Build an app'"
    echo "   - Name your app and choose your repository"
    echo "   - Note the App ID"
    echo
    echo "2. Create a new React app with TypeScript:"
    echo "   npx create-react-app my-gen2-app --template typescript"
    echo "   cd my-gen2-app"
    echo
    echo "3. Initialize Amplify in your project:"
    echo "   amplify init --appId YOUR_APP_ID --envName main"
    echo
    echo "4. Add authentication:"
    echo "   amplify add auth"
    echo "   (Choose default configuration or customize as needed)"
    echo
    echo "5. Add API (optional):"
    echo "   amplify add api"
    echo "   (Select 'GraphQL', then follow prompts to set up your API)"
    echo
    echo "6. Push your changes to deploy Amplify backend:"
    echo "   amplify push --yes"
    echo
    echo "7. Use Amplify in your React app:"
    echo "   // In your src/index.tsx"
    echo "   import { Amplify } from 'aws-amplify';"
    echo "   import awsconfig from './aws-exports';"
    echo "   Amplify.configure(awsconfig);"
    echo
    echo "   // In your components"
    echo "   import { Auth } from 'aws-amplify';"
    echo "   // Use Auth.signIn(), Auth.signOut(), etc."
    echo
    echo "8. Deploy your app:"
    echo "   git push"
    echo "   (Amplify will automatically deploy your updates)"
    echo
}

# Main script execution
main() {
    display_header
    display_description
    get_user_choice

    case $choice in
        1)
            echo "You've chosen to set up a Gen 1 Amplify project."
            echo "Running Gen 1 setup script..."
            ./amplify-gen1-setup-script.bash
            echo
            echo "After running the setup script, follow these steps to create your project:"
            display_gen1_example
            ;;
        2)
            echo "You've chosen to set up a Gen 2 Amplify project."
            echo "Running Gen 2 setup script..."
            ./amplify-gen2-setup-script.bash
            echo
            echo "After running the setup script, follow these steps to create your project:"
            display_gen2_example
            ;;
        *)
            echo "Invalid choice. Please run the script again and select 1 or 2."
            exit 1
            ;;
    esac
}

# Run the main function
main