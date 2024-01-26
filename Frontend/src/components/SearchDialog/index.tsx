import React, { useEffect } from "react";
import { getLocationIcon } from "./locationType";
import { LocationSuggestion } from "../../apis/cctvs";


interface SearchDialogProps {
  getSuggestions: (search: string) => Promise<LocationSuggestion[]>;
}
const SearchDialog = (props: SearchDialogProps) => {
  const { getSuggestions } = props;
  const [suggestions, setSuggestions] = React.useState<LocationSuggestion[]>(
    []
  );
  const [searchTxt, setSearchTxt] = React.useState<string>("Andheri");

  useEffect(() => {
    getSuggestions(searchTxt).then((suggestions) =>
      setSuggestions(suggestions)
    );
  }, [searchTxt, setSuggestions, getSuggestions]);

  useEffect(() => {
    getSuggestions(searchTxt).then((suggestions) =>
      setSuggestions(suggestions)
    );
  }, [searchTxt, getSuggestions]);

  return (
    <div className="absolute m-2 p-2 z-10">
      <div className="">
        <div className="inline-flex flex-col justify-center relative text-gray-500">
          <div className="relative">
            <input
              type="text"
              className="p-2 pl-8 rounded border border-gray-200 focus:bg-white focus:outline-none focus:ring-2 focus:ring-yellow-600 focus:border-transparent"
              placeholder="search..."
              onChange={(e) => setSearchTxt(e.target.value)}
              value={searchTxt}
            />
            <svg
              className="w-4 h-4 absolute left-2.5 top-3.5"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
              />
            </svg>
          </div>
          <h3 className="mt-2 text-sm">Suggestions:</h3>
          <ul className="bg-white border border-gray-100 w-full mt-2 rounded-md p-1">
            {suggestions.map((suggestion) => {
              const LocationIcon = getLocationIcon(suggestion.type);
              return (
                <li
                  className="pl-8 pr-2 py-1 border-b-2 border-gray-100 relative cursor-pointer hover:bg-yellow-50 hover:text-gray-900"
                  key={suggestion.lat + "," + suggestion.lon}
                >
                  <LocationIcon />
                  {suggestion.name}
                </li>
              );
            })}
          </ul>
        </div>
      </div>
    </div>
  );
};

export default SearchDialog;
