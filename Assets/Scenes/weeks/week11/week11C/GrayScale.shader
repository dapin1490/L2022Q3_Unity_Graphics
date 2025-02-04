Shader "Lecture/week11/GrayScale"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Grayness ("Gray amount", Range(0, 1)) = 1
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			sampler2D _MainTex;
			float _Grayness;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 finalcolor;
				fixed4 col = tex2D(_MainTex, i.uv);
				// just invert the colors
				// col.rgb = 1 - col.rgb; // 색 반전

				float gray = (col.r + col.g + col.b) * 0.33;
				// col.rgb = gray;

				finalcolor = lerp(col, gray, _Grayness);

				return finalcolor;
			}
			ENDCG
		}
	}
}
