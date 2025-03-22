import type { PartyInfoRequestMessage_Type } from './generated/F17_PartyInfoRequest';
// ;(async () => {
//     const args = <PartyInfoRequestMessage_Type>{

//     }
// })();

const args: PartyInfoRequestMessage_Type = {
    PartyInfoRequest: {
        Header: {
            Identification: 'id',
            DocumentType: 'F17',
            Creation: new Date(),
            PhysicalSenderEnergyParty: {
                Identification: '6429830251002'
            },
            JuridicalSenderEnergyParty: {
                Identification: '6429830251002'
            },
            JuridicalRecipientEnergyParty: {
                Identification: '6429830251002'
            },
            PhysicalRecipientEnergyParty: {
                Identification: '6429830251002'
            },

        },
        ProcessEnergyContext: {
            EnergyBusinessProcess: 'DH-923-1,',
            EnergyBusinessProcessRole: 'DDQ',
            EnergyIndustryClassification: '23',
        },
        Transaction: {
            PartyInfo: {
                PartyIdentification: 6430074830205,
            }
        }
    },
};

console.log(args);