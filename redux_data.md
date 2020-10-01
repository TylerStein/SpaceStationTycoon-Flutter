# Redux Data Organization

## Overview

**Models**: The structures held by states representing common game objects that change through time and interaction.

**States**: The structures representing the state of the game at any given moment. Changes in state are what trigger the rebuild of widgets.

**Actions**: Objects dispatched to trigger Middleware functions and alter States via Reducers.

**Middlewares**: The functions that triggered by actions, capable of asyncronous processing.

**Reducers**: Functions that consume actions intended to alter states.

## Models

**Modules & Submodules**: Modules/submodules are objects that can be built in game that visitors can be bound to

## States
**Module State**: Contains the active Modules present on the station.

**Visitor State**: Contains the active Visitors present on the station.

**Module-Visitor Binding State**: Contains the relationship between Modules and Visitors.

