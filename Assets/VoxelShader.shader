﻿Shader "Voxel/Opaque" {
	Properties {
		_MainTex ("RGBA", 2D) = "white" {}
		_DetailTex ("MSEU", 2D) = "black" {}
	}
	SubShader {
		Tags { "Queue"="Geometry" "RenderType"="Geometry" }
		LOD 200

		Cull Back
		
		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows

		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _DetailTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;

			fixed4 d = tex2D (_DetailTex, IN.uv_MainTex);
			o.Metallic = d.r;
			o.Smoothness = d.g;
			o.Emission = c.rgb * d.b;
		}
		ENDCG
	}
	FallBack "Standard"
}
