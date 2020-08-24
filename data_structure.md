# Structures
    // Holds a tiered resource count by tier number
    TieredResource {
        Map<int, int> countByTier;
    }

# Data Providers
    // Provides read-only data relating to the game
    MetadataProvider {
        String stationName;
        int day;
    }

    // Provides accumulated resource state
    ResourcesProvider {
        int credits;
        int fuel;
        TieredResource consumerGoods;
        TieredResources repairParts;
    }

    // Provides active visitor references and ID handling
    VisitorProvider {
        Map<VisitorID, Visitor> visitors;
    }

    // Provides unlocks access to see what the player can work with
    UnlocksProvider {
        List<ModuleTempalate> templateUnlocks;
        List<SubmoduleTemplate> submoduleTemplateUnlocks;
    }

    // Provides active station layout references
    ModulesProvider {
        int interiorModuleSlots;
        int exteriorModuleSlots;
        List<ModuleState> interiorModules;
        List<ModuleState> exteriorModules;
    }

# Interaction Handlers
    // Handles interactions and queries when the user attempts to build something
    @requires [ResourcesProvider, UnlocksProvider, ModulesProvider]
    BuildingHandler {
        bool canBuildModule(ModuleTemplate template);
        bool canBuildSubmodule(ModuleState target, SubmoduleTempalate template);
    }

    // Automatically handles game progression without interaction
    @required (all providers???)
    ProgressionHandler {
        // do AI stuff
    }

# Build Hierarchy
    | MultiProvider [
    |     MetadataProvider,
    |     ModulesProvider,
    |     ResourcesProvider,
    |     UnlocksProvider,
    |     VisitorsProvider
    | ]
    |----| TickProvider
         |----| BuildingHandler
              | ProgressionHandler


# Loop Steps
    > Update each Module state
    > Update each Visitor state
    > Update world/economy state

# Visitor Spawning Logic
    > Factory looks at current Station capabilities and spawns ships to make use of those in some randomized combination

# Visitor Needs Loop
    | Visitor
    |----| ShipVisitor
    |----| CrewVisitor

    > Ship arrives with ShipNeeds
    > Each "Need" has a solver that determines if the station can meet it, usually checking for a module's presence and occupancy
    > Needs have priorities that determine the order they are solved in
    > Each Update the Visitor will evaluate it's need and make requests based on that
        > Ship spawns with needs: [ Fuel T1x10, Repair T1x2 ]
        > ShipVisitor occupies Dock slot with contained Fueling submodule
        > Every tick, by using the FuelShipNeed class, the fuel is requested and payment provided

        ShipVisitor.Update
            IF ActiveNeed IS NULL || ActiveNeed IS FUFILLED // Check if a new need should be set
                ActiveNeed = Needs.FirstWhere NEED CAN BE FUFILLED  // Finds the first need (in order of priority) that can be fufilled based on current station status
                MoveToModule ActiveNeed.FindModule // Finds the first module with occupancy that can fufill this need
            
            Need.UpdateNeed // Update the need exchange (eg. ShipVisitor.Fuel++ && StationResources.Fuel-- && StationResources.Credits++)

# Game Loop Optimization
    // The game loop runs once per tick and does a handul of calculations all at once
    // Ideally the providers should notify listeners at the end of the loop instead of using the user-driven accessors
    // Providers can implement interfaces for this

# Simplifying this Polymorphic Horror
    // The only thing you might need objects for are the States
    // Types don't need templates they can just be enums and use maps/factories for default stuff?