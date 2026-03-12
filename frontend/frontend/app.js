let provider = new ethers.BrowserProvider(window.ethereum);
let signer;

async function connectWallet() {
    await provider.send("eth_requestAccounts", []);
    signer = await provider.getSigner();
}

connectWallet();

// Replace with your deployed testnet/mainnet addresses
const donationAddress = "YOUR_DONATION_CONTRACT_ADDRESS";
const governanceAddress = "YOUR_GOVERNANCE_CONTRACT_ADDRESS";

// Replace with compiled contract ABIs
const donationABI = [ /* Paste Donation.sol ABI */ ];
const governanceABI = [ /* Paste Governance.sol ABI */ ];

const donationContract = new ethers.Contract(donationAddress, donationABI, signer);
const governanceContract = new ethers.Contract(governanceAddress, governanceABI, signer);

async function createProject() {
    const name = document.getElementById("projectName").value;
    await donationContract.createProject(name);
    alert("Project created!");
}

async function donate() {
    const projectId = document.getElementById("projectId").value;
    const amount = document.getElementById("donationAmount").value;
    await donationContract.donate(projectId, { value: ethers.parseEther(amount) });
    alert("Donation sent!");
}

async function voteProposal() {
    const proposalId = document.getElementById("proposalId").value;
    await governanceContract.vote(proposalId);
    alert("Voted successfully!");
}
