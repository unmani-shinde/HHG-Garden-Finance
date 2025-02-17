import { useAccount } from "wagmi"
import { CHAIN_IDS } from "./ChoseChainComponent";

export default function TokenDetailsComponent() {

    const account = useAccount();

    return (
      <>
        <div className="flex min-h-full flex-1 flex-col justify-center px-6 py-12 lg:px-8">
          <div className="sm:mx-auto sm:w-full sm:max-w-sm">
            <h2 className="mt-1 text-center text-2xl font-bold leading-9 tracking-tight text-gray-900">
              Create Your Estate Token
            </h2>
          </div>
  
          <div className="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
            <form action="#" method="POST" className="space-y-6">
              <div>
                <label htmlFor="metadata" className="block text-md font-medium leading-6 text-gray-900">
                  Token Metadata
                </label>
                <div className="mt-2">
                  <input
                    id="metadata"
                    name="metadata"
                    type="text"
                    required
                    autoComplete="email"
                    className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>
  
              <div>
                <div className="flex items-center justify-between">
                  <label htmlFor="password" className="block text-md font-medium leading-6 text-gray-900">
                    Evaluation (in {CHAIN_IDS.find(chain => chain.chainID === account.chainId).currency})
                  </label>
                  {/* <div className="text-sm">
                    <a href="#" className="font-semibold text-indigo-600 hover:text-indigo-500">
                      Forgot password?
                    </a>
                  </div> */}
                </div>
                <div className="mt-2">
                  <input
                    id="evaluation"
                    name="evaluation"
                    type="text"
                    required
                    className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>
  
              <div>
                <button
                  type="submit"
                  className="flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                >
                  Create Token
                </button>
              </div>
            </form>
  
            <p className="mt-10 text-center text-md text-gray-500">
              View your Account{' '}
              <a href={CHAIN_IDS.find(chain => chain.chainID === account.chainId).explorer+account.address} className="font-semibold leading-6 text-indigo-600 hover:text-indigo-500">
                on Block Explorer
              </a>
            </p>
          </div>
        </div>
      </>
    )
  }
  