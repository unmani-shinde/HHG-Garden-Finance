export function Stepper(){

    const stepperOptions = [{
        label: 1,
        value: 'Estate Token Details'
    },{
        label: 2,
        value: 'Chain of Deployment'
    },{
        label: 3,
        value: 'Wrapped Tokens Import'
    },{ 
        label: 4,
        value: 'Confirmation'
    }
        
    ]

    return(
        <ol className="flex items-center flex-row justify-center w-full p-3 space-x-2 text-sm font-medium text-center text-gray-500 dark:text-gray-400 sm:text-base sm:p-4 sm:space-x-4 rtl:space-x-reverse">

            {stepperOptions.map((option,index)=>{
                return(
                    <li key={index} className="flex items-center text-blue-600 dark:text-blue-500 ">
        <span className="flex items-center justify-center w-5 h-5 me-2 text-xs border border-blue-600 rounded-full shrink-0 dark:border-blue-500">
            {option.label}
        </span>
        {option.value}
        {(option.label!==4) && (<svg className="w-3 h-3 ms-2 sm:ms-4 rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 12 10">
            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m7 9 4-4-4-4M1 9l4-4-4-4"/>
        </svg>)}
    </li>
                )
            })}


    
    
</ol>

        



    )
    



}


export default function Tokenize() {

    return(<Stepper/>)
    
}