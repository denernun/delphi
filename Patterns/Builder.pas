{
  The builder pattern is similar to abstract factory, except that the consumer
  only sees the highest level of abstraction. Intermediate products are
  identified in parameters via some kind of index or other key identifier.
}
unit Builder;

interface

uses
  AbstractFactory;

type
  IMazeBuilder = interface
    procedure BuildMaze;
    procedure BuildRoom(ANumber: integer);
    procedure BuildDoor(AFromRoomIndex, AToRoomIndex: integer);
    function GetMaze: IMaze;
  end;

  // We can pass the builder as a parameter for example
  // LMaze := MazeGame.CreateMaze(ABuilder);
  // The game in turn can create the maze in an abstract way.
  // Difference here between the builder and the factory is that the
  // Consumer does not need to know constituant parts

implementation

end.
