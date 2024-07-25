import { ConnectKitButton } from "connectkit";
import { useAccount } from "wagmi";

export default function HomePage() {
    const account = useAccount();

    // if (isConnecting) return <div>Connecting...</div>;
    // if (isDisconnected) return <div>Disconnected</div>;

    return (
        <div className="flex flex-col items-center justify-center pt-32">
            <h1 className="mb-4 text-4xl font-extrabold tracking-tight leading-none text-gray-900 md:text-5xl lg:text-6xl dark:text-white">Real Estate Asset Tokenization Platform</h1>
            <ConnectKitButton/>
            {account.isConnected && (
                <div className="mt-4 pt-4 flex flex-col items-center justify-center">
                    <p>Connected Wallet: {account.address}</p>
                    <p>Connected Network: {account.chainId}</p>
                    <a
                href="/tokenize"
                className="mt-4 rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
              >
                Create My First Estate Token
              </a>
                </div>)}
            
        </div>
    );
}
