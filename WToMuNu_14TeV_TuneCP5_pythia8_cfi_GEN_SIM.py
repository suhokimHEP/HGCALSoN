# Auto generated configuration file
# using: 
# Revision: 1.19 
# Source: /local/reps/CMSSW/CMSSW/Configuration/Applications/python/ConfigBuilder.py,v 
# with command line options: WToMuNu_14TeV_TuneCP5_pythia8_cfi --conditions auto:phase2_realistic_T15 -n 10 --era Phase2C9 --eventcontent FEVTDEBUG --relval 9000,100 -s GEN,SIM --datatier GEN-SIM --beamspot HLLHC --geometry Extended2026D49 --fileout file:step1.root --no_exec
import FWCore.ParameterSet.Config as cms
from FWCore.ParameterSet.VarParsing import VarParsing
options = VarParsing ('python')
options.register('Tag', None, VarParsing.multiplicity.singleton, VarParsing.varType.string, "Tag to digitize")
options.parseArguments()

from Configuration.Eras.Era_Phase2C9_cff import Phase2C9

process = cms.Process('SIM',Phase2C9)

# import of standard configurations
process.load('Configuration.StandardSequences.Services_cff')
process.load('SimGeneral.HepPDTESSource.pythiapdt_cfi')
process.load('FWCore.MessageService.MessageLogger_cfi')
process.load('Configuration.EventContent.EventContent_cff')
process.load('SimGeneral.MixingModule.mixNoPU_cfi')
process.load('Configuration.Geometry.GeometryExtended2026D49Reco_cff')
process.load('Configuration.Geometry.GeometryExtended2026D49_cff')
process.load('Configuration.StandardSequences.MagneticField_cff')
process.load('Configuration.StandardSequences.Generator_cff')
process.load('IOMC.EventVertexGenerators.VtxSmearedHLLHC_cfi')
process.load('GeneratorInterface.Core.genFilterSummary_cff')
process.load('Configuration.StandardSequences.SimIdeal_cff')
process.load('Configuration.StandardSequences.EndOfProcess_cff')
process.load('Configuration.StandardSequences.FrontierConditions_GlobalTag_cff')

process.maxEvents = cms.untracked.PSet(
    input = cms.untracked.int32(40),
    output = cms.optional.untracked.allowed(cms.int32,cms.PSet)
)

from IOMC.RandomEngine.RandomServiceHelper import RandomNumberServiceHelper
randHelper=RandomNumberServiceHelper(process.RandomNumberGeneratorService)
randHelper.populate()
# Input source
process.source = cms.Source("EmptySource")

process.options = cms.untracked.PSet(
    FailPath = cms.untracked.vstring(),
    IgnoreCompletely = cms.untracked.vstring(),
    Rethrow = cms.untracked.vstring(),
    SkipEvent = cms.untracked.vstring(),
    allowUnscheduled = cms.obsolete.untracked.bool,
    canDeleteEarly = cms.untracked.vstring(),
    deleteNonConsumedUnscheduledModules = cms.untracked.bool(True),
    dumpOptions = cms.untracked.bool(False),
    emptyRunLumiMode = cms.obsolete.untracked.string,
    eventSetup = cms.untracked.PSet(
        forceNumberOfConcurrentIOVs = cms.untracked.PSet(
            allowAnyLabel_=cms.required.untracked.uint32
        ),
        numberOfConcurrentIOVs = cms.untracked.uint32(0)
    ),
    fileMode = cms.untracked.string('FULLMERGE'),
    forceEventSetupCacheClearOnNewRun = cms.untracked.bool(False),
    makeTriggerResults = cms.obsolete.untracked.bool,
    numberOfConcurrentLuminosityBlocks = cms.untracked.uint32(0),
    numberOfConcurrentRuns = cms.untracked.uint32(1),
    numberOfStreams = cms.untracked.uint32(0),
    numberOfThreads = cms.untracked.uint32(1),
    printDependencies = cms.untracked.bool(False),
    sizeOfStackForThreadsInKB = cms.optional.untracked.uint32,
    throwIfIllegalParameter = cms.untracked.bool(True),
    wantSummary = cms.untracked.bool(False)
)

# Production Info
process.configurationMetadata = cms.untracked.PSet(
    annotation = cms.untracked.string('WToMuNu_14TeV_TuneCP5_pythia8_cfi nevts:10'),
    name = cms.untracked.string('Applications'),
    version = cms.untracked.string('$Revision: 1.19 $')
)

# Output definition

process.FEVTDEBUGoutput = cms.OutputModule("PoolOutputModule",
    SelectEvents = cms.untracked.PSet(
        SelectEvents = cms.vstring('generation_step')
    ),
    dataset = cms.untracked.PSet(
        dataTier = cms.untracked.string('GEN-SIM'),
        filterName = cms.untracked.string('')
    ),
    fileName = cms.untracked.string('WToMuNu_14TeV_TuneCP5_pythia8_cfi_%s.root'%options.Tag),
    outputCommands = process.FEVTDEBUGEventContent.outputCommands,
    splitLevel = cms.untracked.int32(0)
)

# Additional output definition

# Other statements
process.genstepfilter.triggerConditions=cms.vstring("generation_step")
from Configuration.AlCa.GlobalTag import GlobalTag
process.GlobalTag = GlobalTag(process.GlobalTag, 'auto:phase2_realistic_T15', '')

process.generator = cms.EDFilter("Pythia8ConcurrentGeneratorFilter",
    PythiaParameters = cms.PSet(
        parameterSets = cms.vstring(
            'pythia8CommonSettings',
            'pythia8CP5Settings',
            'processParameters'
        ),
        processParameters = cms.vstring(
            'WeakSingleBoson:ffbar2W = on',
            '24:onMode = off',
            '24:onIfAny = 13 14'
        ),
        pythia8CP5Settings = cms.vstring(
            'Tune:pp 14',
            'Tune:ee 7',
            'MultipartonInteractions:ecmPow=0.03344',
            'MultipartonInteractions:bProfile=2',
            'MultipartonInteractions:pT0Ref=1.41',
            'MultipartonInteractions:coreRadius=0.7634',
            'MultipartonInteractions:coreFraction=0.63',
            'ColourReconnection:range=5.176',
            'SigmaTotal:zeroAXB=off',
            'SpaceShower:alphaSorder=2',
            'SpaceShower:alphaSvalue=0.118',
            'SigmaProcess:alphaSvalue=0.118',
            'SigmaProcess:alphaSorder=2',
            'MultipartonInteractions:alphaSvalue=0.118',
            'MultipartonInteractions:alphaSorder=2',
            'TimeShower:alphaSorder=2',
            'TimeShower:alphaSvalue=0.118',
            'SigmaTotal:mode = 0',
            'SigmaTotal:sigmaEl = 21.89',
            'SigmaTotal:sigmaTot = 100.309',
            'PDF:pSet=LHAPDF6:NNPDF31_nnlo_as_0118'
        ),
        pythia8CommonSettings = cms.vstring(
            'Tune:preferLHAPDF = 2',
            'Main:timesAllowErrors = 10000',
            'Check:epTolErr = 0.01',
            'Beams:setProductionScalesFromLHEF = off',
            'SLHA:minMassSM = 1000.',
            'ParticleDecays:limitTau0 = on',
            'ParticleDecays:tau0Max = 10',
            'ParticleDecays:allowPhotonRadiation = on'
        )
    ),
    comEnergy = cms.double(14000.0),
    crossSection = cms.untracked.double(17120.0),
    filterEfficiency = cms.untracked.double(1.0),
    maxEventsToPrint = cms.untracked.int32(0),
    pythiaHepMCVerbosity = cms.untracked.bool(False),
    pythiaPylistVerbosity = cms.untracked.int32(0)
)

#process.electronRefs = cms.EDProducer("PdgIdCandRefVectorSelector",
#src = cms.InputTag("genParticleCandidates"),
#pdgId = cms.vint32( 11 )
#)
#
#process.bestElectrons = cms.EDFilter("EtaPtMinCandViewSelector",
#   src = cms.InputTag("electronRefs"),
#   ptMin = cms.double( 20 ),
#   etaMin = cms.double( -2.5 ),
#   etaMax = cms.double( 2.5 )
# )
#process.bestMuons = cms.EDFilter("PtMinCandViewSelector",
#    src = cms.InputTag("muons"),
#    ptMin = cms.double(10)
#  )

#process.genmuons = cms.EDProducer("PdgIdCandSelector",
#    src = cms.InputTag('genParticleCandidates'), 
##    src = cms.InputTag('generator'), 
#    pdgId = cms.vint32( 13 )
#  )
#
#
#process.genmuonshgcal = cms.EDProducer("CandSelector",
#    src = cms.InputTag("genmuons"),
#    cut = cms.string("pt < 4 & abs(eta)>1.4 & abs( eta ) < 2.5")
#  )
#
#process.genmuonshgcalfilter = cms.EDFilter("CandViewCountFilter",
#    src = cms.InputTag("genmuonshgcal"),
#    minNumber = cms.uint32(1),
#  )

#process.mugenfilter = cms.EDFilter("MCSmartSingleParticleFilter",
#                            MinPt = cms.untracked.vdouble(10.,10.),
#                            MinEta = cms.untracked.vdouble(1.4,1.4),
#                            MaxEta = cms.untracked.vdouble(2.5,2.5),
#                            ParticleID = cms.untracked.vint32(13,-13),
#                            Status = cms.untracked.vint32(1,1),
#                            ## Decay cuts are in mm
#                            #MaxDecayRadius = cms.untracked.vdouble(2000.,2000.),
#                            #MinDecayZ = cms.untracked.vdouble(-4000.,-4000.),
#                            #MaxDecayZ = cms.untracked.vdouble(4000.,4000.)
# )

process.ProductionFilterSequence = cms.Sequence(process.generator)
#process.ProductionFilterSequence = cms.Sequence(process.generator+process.bestElectrons)
#process.ProductionFilterSequence = cms.Sequence(process.generator+process.genmuonshgcalfilter)
#process.ProductionFilterSequence = cms.Sequence(process.generator+process.genmuons+process.genmuonshgcal+process.genmuonshgcalfilter)
#process.ProductionFilterSequence = cms.Sequence(process.generator+process.mugenfilter)
#process.ProductionFilterSequence = cms.Sequence(process.gen_muons)
#process.ProductionFilterSequence = cms.Sequence(process.gen_muons_hgcal)
#process.ProductionFilterSequence = cms.Sequence(process.gen_muons_hgcal_filter)

# Path and EndPath definitions
process.generation_step = cms.Path(process.pgen)
process.simulation_step = cms.Path(process.psim)
process.genfiltersummary_step = cms.EndPath(process.genFilterSummary)
process.endjob_step = cms.EndPath(process.endOfProcess)
process.FEVTDEBUGoutput_step = cms.EndPath(process.FEVTDEBUGoutput)

# Schedule definition
process.schedule = cms.Schedule(process.generation_step,process.genfiltersummary_step,process.simulation_step,process.endjob_step,process.FEVTDEBUGoutput_step)
from PhysicsTools.PatAlgos.tools.helpers import associatePatAlgosToolsTask
associatePatAlgosToolsTask(process)
# filter all path with the production filter sequence
for path in process.paths:
	getattr(process,path).insert(0, process.ProductionFilterSequence)



# Customisation from command line

# Add early deletion of temporary data products to reduce peak memory need
from Configuration.StandardSequences.earlyDeleteSettings_cff import customiseEarlyDelete
process = customiseEarlyDelete(process)
# End adding early deletion
