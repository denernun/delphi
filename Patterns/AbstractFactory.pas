{
  The abstract factory is a class that creates components and returns them to the
  caller as their abstract types. In this case I chose interfaces over the abstract
  classes as used in the samples of the book. Any number of concrete classes can
  implement the factory interface. The consumer in this case does not see the
  implementation, but just the resultant products.
}

unit AbstractFactory;

interface

uses
  system.generics.collections;

type

  IMaze = interface
    // definition not important for illustration
  end;

  IWall = interface
    // definition not important for illustration
  end;

  IRoom = interface
    // definition not important for illustration
  end;

  IDoor = interface
    // definition not important for illustration
  end;

  IMazeFactory = interface
    function MakeMaze: IMaze;
    function MakeWall: IWall;
    function MakeRoom(ANumber: integer): TArray<IRoom>;
    function MakeDoor(AFromRoom, AToRoom: IRoom): IDoor;
  end;

  // We can pass the factory as a parameter for example
  // MazeGame.CreateMaze(AFactory);
  // The game in turn can create the maze in an abstract way.

implementation

end.
