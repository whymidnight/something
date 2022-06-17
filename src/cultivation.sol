// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract seedAccounting {
  struct Strain {
    string name;
  }
  struct Seed {
    Strain strain;
    bool hasSeed;
  }

  // seedInventory(deviceSerial) => Seed
  mapping(string => Seed) public seedInventory;

  function RegisterSeed(
    string memory serial,
    string memory strainName
  ) public virtual {
    seedInventory[serial] = Seed(Strain(strainName), true);

    return;
  }

  // @returns (Strain.name, Seed.plantedEpoch)
  function GetSeed(string memory deviceSerial)
    public
    view
    returns (string memory, bool)
  {
    Seed memory seed = seedInventory[deviceSerial];

    return (seed.strain.name, seed.hasSeed);
  }
}

contract cultivationAccounting {
  /*
    # Cannabis Growth Timeline
    ---
    1. Germinating: 1-7 days
    2. Seedling: 2-3 weeks
    3. Vegetative: 2-8 weeks
    4. Pre-Flowering: 1-2 weeks
    5. Flowering: 6-8 weeks
    6. Harvesting
    --- https://cleanleaf.com/the-stages-of-cannabis-growth.php
  */
  uint8 public constant Stages = 6;
  struct Germinating {
    bool inState;
    uint64 epoch;
  }
  struct Seedling {
    bool inState;
    uint64 epoch;
  }
  struct Vegetative {
    bool inState;
    uint64 epoch;
  }
  struct PreFlowering {
    bool inState;
    uint64 epoch;
  }
  struct Flowering {
    bool inState;
    uint64 epoch;
  }
  struct Harvesting {
    bool inState;
    uint64 epoch;
  }
  struct GrowthTimeline {
    uint64 plantedEpoch;
    uint8 stage;
    Germinating germinating;
    Seedling seedling;
    Vegetative vegetative;
    PreFlowering preFlowering;
    Flowering flowering;
    Harvesting harvesting;
  }

  // mapping(deviceSerial => GrowthTimeline)
  mapping(string => GrowthTimeline) public records;

  // @returns (inState, error)
  function findInStateForStage(
    GrowthTimeline memory timeline,
    uint8 stage
  ) public pure returns (bool, bool) {
    if (stage == 0) {
      if (timeline.germinating.inState) {
        return (true, false);
      }
    }
    if (stage == 1) {
      if (timeline.seedling.inState) {
        return (true, false);
      }
    }
    if (stage == 2) {
      if (timeline.vegetative.inState) {
        return (true, false);
      }
    }
    if (stage == 3) {
      if (timeline.preFlowering.inState) {
        return (true, false);
      }
    }
    if (stage == 4) {
      if (timeline.flowering.inState) {
        return (true, false);
      }
    }
    if (stage == 5) {
      if (timeline.harvesting.inState) {
        return (true, false);
      }
    }

    return (false, true);
  }

  function findInState(GrowthTimeline memory timeline)
    public
    pure
    returns (bool, uint8)
  {
    (bool state, ) = findInStateForStage(
      timeline,
      timeline.stage
    );
    return (state, timeline.stage);
  }

  function Advance(string memory deviceSerial)
    public
    virtual
  {
    // ensure no re-entry and
    // panic on cultivation completion
    require(
      records[deviceSerial].stage < Stages,
      "cultivation completed"
    );

    (, uint8 stage) = findInState(records[deviceSerial]);
    if (stage == 0) {
      records[deviceSerial].germinating.inState = false;
      records[deviceSerial].seedling.inState = true;
      records[deviceSerial].stage = 1;
    }
    if (stage == 1) {
      records[deviceSerial].seedling.inState = false;
      records[deviceSerial].vegetative.inState = true;
      records[deviceSerial].stage = 2;
    }
    if (stage == 2) {
      records[deviceSerial].vegetative.inState = false;
      records[deviceSerial].preFlowering.inState = true;
      records[deviceSerial].stage = 3;
    }
    if (stage == 3) {
      records[deviceSerial].preFlowering.inState = false;
      records[deviceSerial].flowering.inState = true;
      records[deviceSerial].stage = 4;
    }
    if (stage == 4) {
      records[deviceSerial].flowering.inState = false;
      records[deviceSerial].harvesting.inState = true;
      records[deviceSerial].stage = 5;
    }
    if (stage == 5) {
      records[deviceSerial].harvesting.inState = false;
      records[deviceSerial].stage = 6;
    }

    return;
  }

  function StartGrowth(
    string memory deviceSerial,
    uint64 plantedEpoch
  ) public virtual {
    records[deviceSerial] = GrowthTimeline({
      plantedEpoch: plantedEpoch,
      stage: 0,
      germinating: Germinating({inState: true, epoch: 1}),
      seedling: Seedling({inState: false, epoch: 0}),
      vegetative: Vegetative({inState: false, epoch: 0}),
      preFlowering: PreFlowering({
        inState: false,
        epoch: 0
      }),
      flowering: Flowering({inState: false, epoch: 0}),
      harvesting: Harvesting({inState: false, epoch: 0})
    });
  }
}
