Log.setLevel( "ALL" )

local imageNumber = 0
-- Create an instance of a viewer:
local myViewer = View.create( "2DImageDisplay" )

local function handleOnNewImage( inImage )
  --print( inImage:toString() )
  Log.info( inImage:toString() )
  -- Clear viewer from previously shown data:
  myViewer:clear()
  local myIconicID = myViewer:addImage( inImage )
  myViewer:present( "ASSURED" )
end

local function loadNextImage()
  if ( imageNumber == 0 ) then
    Log.warning( "Will start at first image!" )
  end
  print( "Will load image '" .. imageNumber .. ".png' ..." )
  local myImage = Image.load( "resources/" .. imageNumber .. ".png" )
  imageNumber = ( imageNumber + 1 ) % 13
  handleOnNewImage( myImage )
end

local imageTimer = Timer.create()
imageTimer:setExpirationTime( 3000 )   -- in [ms]
imageTimer:setPeriodic( true )
imageTimer:register( "OnExpired", loadNextImage )
Log.severe( "Timer has been registered!" )

local function main()
  print( "Hello world!" )
  local myText = "This is me!"
  print( "content of 'myText' is: '" .. myText .. "';" )
  imageTimer:start()
  loadNextImage()
end
Script.register( "Engine.OnStarted", main )
