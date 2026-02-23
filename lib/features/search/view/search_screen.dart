import 'package:hdbox_app/core/helpers/app_imports.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => SearchCubit()..getTopSearch(),
  child: BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        String formatedYearDate({required String date}) {
          if (date == null || date.isEmpty) return "Unknown year";
          try {
            DateTime dateTime = DateTime.parse(date);
            String formatedDate = dateTime.year.toString();
            return formatedDate;
          } catch (e) {
            return 'Unknown year';
          }
        }

        var cubit = SearchCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
                top: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search',
                    style: TextStyle(
                      color: ColorManager.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff333333),
                      borderRadius: BorderRadiusGeometry.circular(15.0),
                    ),
                    margin: const EdgeInsets.only(top: 15.0),
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: ColorManager.baseColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: ColorManager.baseColor),
                        ),
                        hintText: 'Enter here to search a movie',
                        hintStyle: TextStyle(color: ColorManager.white),
                        suffixIcon:cubit.searchText.isNotEmpty? IconButton(
                          icon: Icon(
                            Icons.close,
                            color: ColorManager.white,
                            size: 17.0,
                          ),
                          onPressed: () {
                            searchController.clear();
                            cubit.clearSearchField();
                          },
                        ):null,
                      ),
                      style: TextStyle(color: ColorManager.white),
                      onChanged: (value) {
                        cubit.getMultiSearch(q: value);
                        cubit.searchText = value;
                      },
                    ),
                  ),
                  if (cubit.searchText.isNotEmpty)
                    ConditionalBuilder(
                      condition: cubit.multiSearchModel != null,
                      builder: (context) => Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final movie =
                                cubit.multiSearchModel!.results[index];
                            return SearchInfoRow(
                              onTap: () {
                                if (movie.isMovie) {
                                  navigateTo(
                                    context,
                                    FullDetailsMoviesScreen(movieId: movie.id!),
                                  );
                                } else if (movie.isTv) {
                                  navigateTo(
                                    context,
                                    FullDetailsTvMoviesScreen(
                                      movieId: movie.id!,
                                    ),
                                  );
                                }
                              },
                              title: movie.displayTitle,
                              date: formatedYearDate(date: movie.displayDate),
                            );
                          },
                          itemCount: cubit.multiSearchModel!.results.length,
                        ),
                      ),
                      fallback: (context) => Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 10.0,
                          ),
                          child: LinearProgressIndicator(
                            color: ColorManager.red,
                          ),
                        ),
                      ),
                    ),
                  if (cubit.searchText.isEmpty)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25.0),
                      child: Text('Top Searches', style: style(27.0)),
                    ),
                  if (cubit.searchText.isEmpty)
                    ConditionalBuilder(
                      condition: cubit.topSearchModel != null,
                      builder: (context) => Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var movie = cubit.topSearchModel!.results![index];
                            return TopSearchItem(
                              onTap: () {
                                navigateTo(
                                  context,
                                  FullDetailsMoviesScreen(movieId: movie.id!),
                                );
                              },
                              image:
                                  movie.posterPath ?? movie.backdropPath ?? '',
                              title:
                                  cubit
                                      .topSearchModel!
                                      .results![index]
                                      .title ??
                                  "Untitled",
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20.0),
                          itemCount: cubit.topSearchModel!.results!.length,
                        ),
                      ),
                      fallback: (context) => BuildFullBack(),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    ),
);
  }
}
