package app.model.vo
{

public class ConfigVo
{
	public var services:Object;
	
	public function ConfigVo( $json:Object ):void
	{
		services = $json.services;
	}
}

}