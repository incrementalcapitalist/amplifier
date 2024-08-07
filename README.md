---

# AWS Amplify Starter Template

This repository provides a starter template for AWS Amplify development. It includes a bash script (`initialize.bash`) that automates the setup of the necessary tools and configuration for AWS Amplify on a new environment.

## Prerequisites

Before running the setup script, ensure you have the following:

- An **AWS account** with sufficient permissions to create and manage Amplify projects.
- Access to an **Ubuntu** environment (local or EC2 instance) with internet connectivity.

## Setup Instructions

### 1. Clone the Repository

First, clone this repository to your local machine or remote environment:

```bash
git clone https://github.com/yourusername/aws-amplify-starter-template.git
cd aws-amplify-starter-template
```

### 2. Run the Initialization Script

The `initialize.bash` script will set up the necessary environment for AWS Amplify development. During the script's execution, you will be prompted to enter a name for your AWS Amplify project.

To run the script, use the following command:

```bash
bash initialize.bash
```

### Script Workflow

When you run the script, it will perform the following actions:

1. **Prompt for Project Name:**
   - You will be asked to enter a name for your AWS Amplify project. This name will be used to create a directory and initialize your Amplify project.

2. **System Update and Upgrade:**
   - Updates the package index.
   - Performs a full system upgrade to ensure all packages are up to date.

3. **Install Dependencies:**
   - Installs `unzip` and `curl` for downloading and extracting files.

4. **Install AWS CLI:**
   - Downloads and installs the AWS CLI (version 2).

5. **Install Node Version Manager (NVM) and Node.js:**
   - Installs NVM to manage Node.js versions.
   - Installs the latest stable version of Node.js and npm.

6. **Install Amplify CLI:**
   - Installs the Amplify CLI globally using npm.

7. **AWS CLI and Amplify CLI Configuration:**
   - Prompts you to configure AWS CLI with your credentials.
   - Sets up AWS Amplify for use in your projects.

8. **Initialize a New Amplify Project:**
   - Creates a directory with the name you provided for your Amplify project.
   - Initializes a new Amplify project in this directory.

### 3. Verify Installation

After running the script, you can verify the installation by checking the versions of the installed tools:

```bash
nvm -v
node -v
npm -v
aws --version
amplify --version
```

These commands should return the installed versions of NVM, Node.js, npm, AWS CLI, and Amplify CLI.

### 4. Start Developing with AWS Amplify

Navigate to the newly created Amplify project directory and start developing your application:

```bash
cd your-project-name
```

Replace `your-project-name` with the name you provided during the script execution.

## Troubleshooting

- **AWS CLI or Amplify CLI not recognized**: Ensure that your PATH is correctly set. You can manually add paths to your `.bashrc` or `.bash_profile` if necessary.
- **Permission Denied Errors**: Make sure you are running the script with sufficient permissions (`sudo` may be required for some commands).
- **Script Errors:** If any errors occur during the script execution, they will be logged, and you will be notified to review the log for troubleshooting.

## Contributing

If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the GNU General Public License (GPL) v3.0. See the [LICENSE](LICENSE) file for more information.

### Why GPL v3?

The GPL v3 license enforces strong copyleft requirements and ensures that all derivative works of this project remain open source. This license also provides additional protections against patent claims, aligning with our goal to keep contributions and derivatives freely available and to safeguard the project's integrity and freedom.

---
