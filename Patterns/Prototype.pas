{
  This is one of my favorite design patterns. To use it you provide prototype
  instances during construction. These will then be used to create clones in the
  factory. This provides extensibility where you have no access to the code
  (like a user-defined extension or plug-in).
}
unit Prototype;

interface

uses
  system.generics.collections;

type

  IMaze = interface
    function Clone: IMaze;
    // rest of definition not important for illustration
  end;

  IWall = interface
    function Clone: IWall;
    // rest of definition not important for illustration
  end;

  IRoom = interface
    function Clone: IRoom;
    // rest of definition not important for illustration
  end;

  IDoor = interface
    function Clone: IDoor;
    procedure Initialize(AFromRoom, AToRoom: IRoom); // mutator
    // rest of definition not important for illustration
  end;

  TMazePrototypeFactory = Class
  private
    FProtoMaze: IMaze;
    FProtoWall: IWall;
    FProtoRoom: IRoom;
    FProtoDoor: IDoor;
  public
    constructor Create(AMaze: IMaze; AWall: IWall; ARoom: IRoom; ADoor: IDoor);

    function MakeMaze: IMaze;
    function MakeWall: IWall;
    function MakeRoom(ANumber: integer): TList<IRoom>;
    function MakeDoor(AFromRoom, AToRoom: IRoom): IDoor;
  end;

  // We can pass the factory as a parameter for example
  // MazeGame.CreateMaze(AFactory);
  // The game in turn can create the maze in an abstract way.

implementation

constructor TMazePrototypeFactory.Create(AMaze: IMaze; AWall: IWall; ARoom: IRoom; ADoor: IDoor);
begin
  inherited Create;
  FProtoMaze := AMaze;
  FProtoWall := AWall;
  FProtoRoom := ARoom;
  FProtoDoor := ADoor;
end;

function TMazePrototypeFactory.MakeMaze: IMaze;
begin
  result := FProtoMaze.Clone;
end;

function TMazePrototypeFactory.MakeWall: IWall;
begin
  result := FProtoWall.Clone;
end;

function TMazePrototypeFactory.MakeRoom(ANumber: integer): TList<IRoom>;
var
  I: Integer;
begin
  for I := 1 to ANumber do
  begin
    Result.Add(FProtoRoom.Clone);
  end;
end;

function TMazePrototypeFactory.MakeDoor(AFromRoom: IRoom; AToRoom: IRoom): IDoor;
begin
  //Result := IDoor.Clone;
  Result.Initialize(AFromRoom, AToRoom);
end;

end.
