var Loader = (function() {
	return {
		chatty: false,
		sources: [],
		total: 0,
		images: [],
		loaded: 0,
		percent: 0,
		element: 0,
		scope: 0,
		init: function(ele){
			var cssFiles = document.styleSheets;
			this.element = ele;

			if ( !cssFiles.length ) {
				if (this.chatty) console.log( 'Loader: No document stylesheets found. Calling home...' );
				this.end();
				return;
			}

			var i, l_1 = cssFiles.length,
				j, l_2,
				k, l_3,
				type, rules, mediaRules;

			for ( i = 0; i < l_1; ++i ) {
				rules = cssFiles[i].rules || cssFiles[i].cssRules;
				if ( ! rules.length ) continue;

				if (this.chatty) console.log( 'Loader: Parsing', cssFiles[i].href );

				l_2 = rules.length;
				for ( j = 0; j < l_2; ++j ) {
					type = rules[j].type;

					//Skip all but CSSStyleRule (1) and CSSMediaRule (4) elements.
					//NOTE: ie8 does not have 'type' attribute so we are also checking if it's present at all.
					if ( type && type !== 1 && type !== 4 ) continue;

					//If rule is a MediaRule, traverse it's substyles.
					if ( type === 4 ) {
						mediaRules = rules[j].cssRules;
						l_3 = mediaRules.length;

						for ( k = 0; k < l_3; ++k ) {
							if ( mediaRules[k].type !== 1 ) continue;

							//Push bg image path to hashmap.
							if ( mediaRules[k].style ) this.addSource( mediaRules[k].style.backgroundImage );
						}

						continue;
					}

					//Push bg image path to hashmap.
					if ( rules[j].style ) this.addSource( rules[j].style.backgroundImage );
				}
			}

			this.filterSources();
		},
		addSource: function( src ) {
			if ( !src || src == 'initial' || src == 'none' ) {
				return false;
			}

			//Using actual path as a key to avoid dealing with dupes later.
			this.sources[src] = 1;
			return true;
		},
		end: function() {
			if (this.chatty) console.log( 'Loader: Finished...' );
			this.element.attr("class", "boom");
			$(this.element).parent().parent().delay( 500 ).fadeOut("slow", function(){
				this.remove();
			});
		},
		filterSources: function() {

			var highDPI = true;
			var tmp = [];

			for ( var src in this.sources ) {

				// @author njmcode - ensure non-URL sources (e.g CSS gradients) are ignored
				if ( src.substr(0,3) !== 'url' ) continue;

				if ( src.indexOf( this.retinaDenominator ) == -1 ) {
					tmp.push( src.slice( 4, -1 ).replace(/["']/g, "") );
				} else if ( highDPI ) {
					tmp.push( src.slice( 4, -1 ).replace(/["']/g, "") );
				}
			}
			this.sources = tmp;
			tmp = null;

			this.total = this.sources.length;

			this.createImageLoaders();
		},
		createImageLoaders: function() {
			var that = this;
			var i, l = this.sources.length;

			for ( i = 0; i < l; ++i ) {

				if ( this.sources[i].indexOf( ')' ) > -1 ) {
					this.total -= 1;
					continue;
				}

				this.images[i] = new Image();
				//this.images[i].onload = function() {that.onImageComplete( this.src, true ); };
				//this.images[i].onerror = function() {that.onImageComplete( this.images[i].src, false ); };
				this.images[i].onload = onLoadhandler;
				this.images[i].onerror = onErrorhandler;

				this.images[i].src = this.sources[i];
			}
			function onLoadhandler() {
				that.onImageComplete( this.src, true );
			}
			function onErrorhandler() {
				that.onImageComplete( this.src, false );
			}
		},
		onImageComplete: function( img, success ) {
			if(success) {
				this.loaded++;
				this.percent = ( this.loaded == this.total ) ? 100 : Math.ceil( this.loaded / this.total * 100 );
				if (this.chatty) console.log( "ImagePreloader: Current percent:", this.percent, '	Loaded ok:', success );

				//Trigger progress callback
				if ( this.onProgress ) {
					this.onProgress( this.percent );
				}

				//Trigger finished callback
				if ( this.loaded == this.total ) {
					this.end();
				}
			}
		},
		onProgress: function(percent) {
			//console.log(this.element);
			this.element.css({height: percent+"%"});
		}
	};
}());